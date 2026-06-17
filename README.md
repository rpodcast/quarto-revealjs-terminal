# Terminal — a Quarto reveal.js slide theme

A retro **computer-terminal** theme for [Quarto Revealjs](https://quarto.org/docs/presentations/revealjs/) presentations: dark background, amber pixel-glow headings, monospace body text, bordered terminal callout boxes, a top status bar, and a bottom footer with a slide counter, progress dots, and a `press → to continue` hint.

All colors, fonts, and effects are **fully customizable** via SCSS variables —
including ready-made color schemes (e.g. `solarized-dark`, `dracula`,
`nord`) selectable with a single `$terminal-palette` setting.

## Usage

Depending on your use case, the Terminal theme can be installed using the following procedures:

* To add the Terminal theme to an existing directory with your Quarto Revealjs presentation:

```
quarto add rpodcast/quarto-revealjs-terminal
```

* To start a new Quarto revealjs presentation project with the Terminal theme, including a `.qmd` starter presentation file:

```
quarto use template rpodcast/quarto-revealjs-terminal
```

## Existing Quarto Templates

The following slide templates were used as references:

* quakr slide template: https://github.com/ThinkR-open/quakr/tree/main
* quarto clean theme: https://github.com/grantmcdermott/quarto-revealjs-clean
* quarto revealjs template storybook: https://github.com/mcanouil/quarto-revealjs-storybook
