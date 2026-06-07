-- terminal.lua
-- Injects a terminal-style status bar (top) and footer with progress dots
-- (bottom) into every reveal.js slide.
--
-- Per-slide options are read from the slide's level-2 header attributes:
--
--   ## My Slide {terminal-path="masterclass/module-04" terminal-status="LESSON 4 / 11"}
--
-- Document-level defaults (in YAML front matter) are also supported:
--
--   terminal-path: "part-01/overview"
--   terminal-hint: "press → to continue"
--   terminal-statusbar: true   # set false to hide the top bar
--   terminal-footer: true      # set false to hide the bottom footer
--   terminal-dots: true        # set false to hide progress dots

local meta_defaults = {
  path = nil,
  hint = "press → to continue",
  statusbar = true,
  footer = true,
  dots = true,
}

-- Read a metadata value as a plain string.
local function meta_string(v)
  if v == nil then return nil end
  if type(v) == "string" then return v end
  return pandoc.utils.stringify(v)
end

local function meta_bool(v, default)
  if v == nil then return default end
  if type(v) == "boolean" then return v end
  local s = pandoc.utils.stringify(v):lower()
  if s == "false" or s == "no" or s == "0" then return false end
  if s == "true" or s == "yes" or s == "1" then return true end
  return default
end

function Meta(meta)
  if meta["terminal-path"] then
    meta_defaults.path = meta_string(meta["terminal-path"])
  end
  if meta["terminal-hint"] then
    meta_defaults.hint = meta_string(meta["terminal-hint"])
  end
  meta_defaults.statusbar = meta_bool(meta["terminal-statusbar"], meta_defaults.statusbar)
  meta_defaults.footer = meta_bool(meta["terminal-footer"], meta_defaults.footer)
  meta_defaults.dots = meta_bool(meta["terminal-dots"], meta_defaults.dots)
  return meta
end

-- Build the top status bar block.
local function build_statusbar(path, status)
  local left = pandoc.Span({}, pandoc.Attr("", {"ts-path"}))
  left.content = {
    pandoc.Span(pandoc.Str(">"), pandoc.Attr("", {"ts-prompt"})),
    pandoc.Str(path or ""),
  }

  local right_content = {}
  if status and status ~= "" then
    table.insert(right_content, pandoc.Span(pandoc.Str("●"), pandoc.Attr("", {"ts-dot"})))
    table.insert(right_content, pandoc.Str(status))
  end
  local right = pandoc.Span(right_content, pandoc.Attr("", {"ts-status"}))

  return pandoc.Div({ pandoc.Plain({ left, right }) },
    pandoc.Attr("", {"terminal-statusbar"}))
end

-- Build the bottom footer with counter, progress dots and hint.
local function build_footer(index, total, hint, show_dots)
  local count_str = string.format("%02d / %02d", index, total)
  local count = pandoc.Span(pandoc.Str(count_str), pandoc.Attr("", {"tf-count"}))

  local dots_inlines = {}
  if show_dots then
    for i = 1, total do
      local classes = {"tf-dot"}
      if i == index then table.insert(classes, "active") end
      table.insert(dots_inlines, pandoc.Span({}, pandoc.Attr("", classes)))
    end
  end
  local dots = pandoc.Span(dots_inlines, pandoc.Attr("", {"tf-dots"}))

  local hintspan = pandoc.Span(pandoc.Str(hint or ""), pandoc.Attr("", {"tf-hint"}))

  return pandoc.Div({ pandoc.Plain({ count, dots, hintspan }) },
    pandoc.Attr("", {"terminal-footer"}))
end

-- Only run for HTML/revealjs output.
if not (quarto and quarto.doc and quarto.doc.is_format("revealjs")) then
  -- Fall back gracefully: do nothing for non-revealjs formats.
  return {}
end

function Pandoc(doc)
  Meta(doc.meta)

  local blocks = doc.blocks

  -- First pass: collect the slide section headers (level 2) so we know
  -- the total slide count and can index them.
  local slide_sections = {}
  for _, blk in ipairs(blocks) do
    if blk.t == "Div" and blk.attr and blk.attr.classes:includes("section") then
      table.insert(slide_sections, blk)
    elseif blk.t == "Header" and blk.level == 2 then
      table.insert(slide_sections, blk)
    end
  end
  local total = #slide_sections
  if total == 0 then total = 1 end

  -- Second pass: walk slides and inject chrome.
  local index = 0

  local function decorate(section_blocks, attr)
    index = index + 1
    local path = meta_defaults.path
    local status = nil
    local hint = meta_defaults.hint
    if attr and attr.attributes then
      path = attr.attributes["terminal-path"] or path
      status = attr.attributes["terminal-status"] or status
      hint = attr.attributes["terminal-hint"] or hint
    end

    local extras = {}
    if meta_defaults.statusbar then
      table.insert(extras, build_statusbar(path, status))
    end
    if meta_defaults.footer then
      table.insert(extras, build_footer(index, total, hint, meta_defaults.dots))
    end
    for _, e in ipairs(extras) do
      table.insert(section_blocks, e)
    end
    return section_blocks
  end

  local new_blocks = {}
  for _, blk in ipairs(blocks) do
    if blk.t == "Div" and blk.attr and blk.attr.classes:includes("section") then
      blk.content = decorate(blk.content, blk.attr)
      table.insert(new_blocks, blk)
    else
      table.insert(new_blocks, blk)
    end
  end

  -- Some Quarto pipelines emit slides as bare Headers (not yet wrapped in
  -- section Divs at this stage). If we never saw section Divs, fall back to
  -- wrapping content following each level-2 header.
  local saw_section = false
  for _, blk in ipairs(blocks) do
    if blk.t == "Div" and blk.attr and blk.attr.classes:includes("section") then
      saw_section = true
      break
    end
  end

  if saw_section then
    doc.blocks = new_blocks
    return doc
  end

  -- Fallback path: group by level-2 headers.
  index = 0
  local grouped = {}
  local current = nil
  local current_attr = nil
  local function flush()
    if current then
      decorate(current, current_attr)
      for _, b in ipairs(current) do table.insert(grouped, b) end
    end
  end
  for _, blk in ipairs(blocks) do
    if blk.t == "Header" and blk.level == 2 then
      flush()
      current = { blk }
      current_attr = blk.attr
    elseif current then
      table.insert(current, blk)
    else
      table.insert(grouped, blk)
    end
  end
  flush()

  doc.blocks = grouped
  return doc
end
