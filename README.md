# Terminal — a Quarto reveal.js slide theme

A retro **computer-terminal** theme for Quarto reveal.js presentations: dark
background, amber pixel-glow headings, monospace body text, bordered terminal
callout boxes, a top status bar (`> path … LESSON 4 / 11`), and a bottom footer
with a slide counter, progress dots, and a `press → to continue` hint.

All colors, fonts, and effects are **fully customizable** via SCSS variables.

## Usage

This repo *is* the extension. To use it in your own project, copy the
`_extensions/terminal/` directory into your project (or
`quarto add <this-repo>` once published), then set the format:

```yaml
---
title: "My Talk"
format: terminal-revealjs
---
```

Render with Quarto:

```bash
quarto render template.qmd      # build the demo
quarto preview template.qmd     # live preview
```

> Quarto is provided by `default.nix`. If it is not on your `PATH`, enter the
> shell first: `nix-shell --run "quarto render template.qmd"`.

## Slide layouts

See `template.qmd` for working examples of each layout:

| Layout | How |
| --- | --- |
| Content title slide | `## TITLE.` + `[// KICKER]{.kicker}` + `[lede]{.lede}` |
| Section-break / divider | `## TITLE. {.section-break}` + `.kicker` / `.lede` / `.desc` (vertically centered, oversized title) |
| Bullets as callout boxes | wrap a list in `::: callouts` |
| Numbered step boxes (`01 02 …`) | wrap an ordered list in `::: steps` |
| Two bordered cards | `::: cards` containing `::: card` divs (title via `[Title]{.card-title}`) |
| Code / file-tree block | a fenced ```` ```text ```` code block |

Helper spans: `[…]{.kicker}` (uppercase label), `[…]{.lede}` (subtitle),
`[…]{.desc}` (muted supporting line), `[…]{.neg}` / `[…]{.ok}` (red / green
emphasis).

### Per-slide status bar / footer

Set attributes on the slide's `##` header:

```markdown
## SKILLS. {terminal-path="masterclass/module-04" terminal-status="LESSON 4 / 11"}
```

- `terminal-path` — left side of the top bar (after the green `>` prompt)
- `terminal-status` — right side of the top bar (with a status dot)
- `terminal-hint` — overrides the footer hint for that slide

Document-level defaults are **first-class options of the format**, declared in
the extension with sensible built-in defaults. Override any of them under
`terminal-revealjs:` in the YAML front matter (you only need to set what you
want to change):

```yaml
---
title: "My Talk"
format:
  terminal-revealjs:
    terminal-path: "part-01/overview"   # default prompt path  (default: "")
    terminal-hint: "press → to continue" # footer hint (this IS the default)
    terminal-statusbar: true            # show the top status bar (default: true)
    terminal-footer: true               # show the bottom footer  (default: true)
    terminal-dots: true                 # show progress dots      (default: true)
---
```

Per-slide header attributes (shown above) override these defaults for that
slide.

## Customizing colors & fonts

Every color and font is a `!default` SCSS variable, so you only override what
you want. Create a `custom.scss` (see the included example) and list it after
the theme:

```yaml
format:
  terminal-revealjs:
    theme:
      - custom.scss
```

```scss
/*-- scss:defaults --*/
$terminal-accent:        #00e0ff;   // cyan instead of amber
$terminal-bg:            #001014;
$terminal-heading-font:  "Press Start 2P", monospace;
$terminal-glow:          false;     // disable heading glow
$terminal-scanlines:     false;     // disable CRT scanlines
```

Key variables: `$terminal-bg`, `$terminal-fg`, `$terminal-muted`,
`$terminal-accent`, `$terminal-accent-bright`, `$terminal-green`,
`$terminal-pink`, `$terminal-border`, `$terminal-body-font`,
`$terminal-heading-font`, `$terminal-glow`, `$terminal-scanlines`. The full,
documented list is at the top of `_extensions/terminal/terminal.scss`.

## Project structure

```
_extensions/terminal/
├── _extension.yml     # defines the terminal-revealjs format + fonts
├── terminal.scss      # theme variables (!default) + rules
└── terminal.lua       # injects status bar + footer/progress dots
template.qmd           # demo deck covering every layout
custom.scss            # example override file
```

## Existing Quarto Templates

The following slide templates were used as references:

* quakr slide template: https://github.com/ThinkR-open/quakr/tree/main
* quarto clean theme: https://github.com/grantmcdermott/quarto-revealjs-clean
* quarto revealjs template storybook: https://github.com/mcanouil/quarto-revealjs-storybook
