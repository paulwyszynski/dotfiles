# Dotfiles

Personal macOS tools backup, managed with
[Dotbot](https://github.com/anishathalye/dotbot).

## Setup

```zsh
./install     # symlinks everything per install.conf.yaml
brew bundle   # installs packages from Brewfile
```

## Layout

- `install.conf.yaml` — canonical symlink map (one entry per config)
- `Brewfile` — Homebrew packages, casks and Mac App Store apps
- `CLAUDE.md` — repo conventions and per-directory notes, for humans and for
  Claude Code
- `TODO.md` — open work items, each with concrete steps
