# Terminal — a Quarto reveal.js slide theme

A retro **computer-terminal** theme for [Quarto Revealjs](https://quarto.org/docs/presentations/revealjs/) presentations: dark background, amber pixel-glow headings, monospace body text, bordered terminal callout boxes, a top status bar, and a bottom footer with a slide counter, progress dots, and a `press → to continue` hint.

All colors, fonts, and effects are **fully customizable** via SCSS variables —
including ready-made color schemes (e.g. `solarized-dark`, `dracula`,
`nord`) selectable with a single `$terminal-palette` setting. Additional details on the theme settings can be found in [guide.md](guide.md)

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

## Motivation

For many of my presentations at conferences and other events, Quarto with the Revealjs format has made creating slides actually fun. Typically I have used the built-in themes with slight customization via CSS. Unrelated to Quarto itself, I have begun to explore novel uses of AI in my development both within statistical computing as well as my general "devops" adventures with Nix, Linux, server administration, and more. While learning about the [Hermes Agent](https://hermes-agent.nousresearch.com/), I discovered the [Hermes Agent Masterclass](https://www.youtube.com/playlist?list=PLmpUb_PWAkDx-VWjh00tVCji794xAa_IX) playlist on YouTube by [Tonbi's AI Garage](https://www.youtube.com/@TonbisAIGarage). 

On top of the excellent walkthroughs of Hermes, the host drafted novel web-based slides with a terminal theme, which were in fact created with the assistance of Claude Code as he discussed in [this video](https://www.youtube.com/watch?v=O_g5aE_v71c). I saw this as a unique opportunity to explore creating my own theme for Quarto Revealjs, with the assistance of Claude in OpenCode.

## References

The following Quarto Revealjs slide templates were used as references during development:

* quakr slide template: https://github.com/ThinkR-open/quakr/tree/main
* quarto clean theme: https://github.com/grantmcdermott/quarto-revealjs-clean
* quarto revealjs template storybook: https://github.com/mcanouil/quarto-revealjs-storybook
