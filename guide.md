
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

## Color palettes (terminal color schemes)

Just like a modern terminal emulator, you can switch the whole deck to a
ready-made color scheme with a single variable. Create a `custom.scss`, list it
after the theme, and set `$terminal-palette`:

```yaml
format:
  terminal-revealjs:
    theme:
      - custom.scss
```

```scss
/*-- scss:defaults --*/
$terminal-palette: "solarized-dark";
```

Available palettes:

| Palette | Mode |
| --- | --- |
| `amber` *(default)* | dark |
| `solarized-dark` | dark |
| `solarized-light` | light |
| `tomorrow-night-eighties` | dark |
| `dracula` | dark |
| `gruvbox-dark` | dark |
| `gruvbox-light` | light |
| `nord` | dark |
| `monokai` | dark |
| `one-dark` | dark |
| `catppuccin-mocha` | dark |
| `green-phosphor` | dark |
| `cyan-navy` | dark |

Light palettes automatically soften the CRT glow and scanlines so they remain
readable on a light background. If you set an unknown name, the theme falls back
to `amber` (with a build-time warning).

You can also start from a palette and override individual colors on top of it:

```scss
/*-- scss:defaults --*/
$terminal-palette: "dracula";   // start from Dracula...
$terminal-accent:  #00e0ff;     // ...but make the accent cyan
```

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

Key variables: `$terminal-palette` (pick a scheme), `$terminal-bg`,
`$terminal-fg`, `$terminal-muted`, `$terminal-accent`, `$terminal-accent-bright`,
`$terminal-green`, `$terminal-pink`, `$terminal-border`, `$terminal-body-font`,
`$terminal-heading-font`, `$terminal-glow`, `$terminal-scanlines`. The full,
documented list (and the palette registry) is at the top of
`_extensions/terminal/terminal.scss`.

## Project structure

```
_extensions/terminal/
├── _extension.yml     # defines the terminal-revealjs format + fonts
├── terminal.scss      # theme variables (!default) + rules
└── terminal.lua       # injects status bar + footer/progress dots
template.qmd           # demo deck covering every layout
custom.scss            # example override file
```