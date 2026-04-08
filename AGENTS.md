# AGENTS.md

## What this repo is

Personal macOS dotfiles for Paul Wyszynski, managed with **Dotbot** (git
submodule at `dotbot/`). No CI, no tests, no build step, no Makefile.

## Bootstrap

```zsh
./install          # syncs dotbot submodule, then runs dotbot with install.conf.yaml
brew bundle        # install/update all packages (run from repo root, uses ./Brewfile)
```

`install` must be run from the repo root; it uses `BASH_SOURCE[0]` to find
itself.

Dotbot phases in `install.conf.yaml`: `clean` → `create` → `link` → `shell`
(runs `setup_homebrew.sh`, `setup_zsh.sh`, `setup_zoxide.sh` in order).

## Adding or changing symlinks

Edit `install.conf.yaml` — the `link:` section is the canonical map. Whole
directories can be linked (e.g. `nvim/`, `ghostty/`, `yazi/`); individual files
are used for tools that don't support XDG config dirs well. Run `./install`
after any change to apply.

## Package management

Add packages to `Brewfile`. Then run `brew bundle`. Commented-out entries
(`zellij`, `yabai`, `skhd`, `amethyst`, etc.) are intentionally unused
replacements — don't re-enable them.

## Directory ownership

| Directory             | Tool               | Notes                                                                    |
| --------------------- | ------------------ | ------------------------------------------------------------------------ |
| `nvim/`               | Neovim (LazyVim)   | Lua config; entry `init.lua` → `config.lazy`                             |
| `zsh/`                | Zsh                | `zshrc` (plugins, aliases, functions), `zshenv` (only `exists()` helper) |
| `ghostty/`            | Ghostty terminal   | Primary terminal; GLSL cursor shader in `shaders/`                       |
| `kitty/`              | Kitty terminal     | Secondary; `kitty-scrollback.nvim` integration                           |
| `tmux/`               | tmux               | Prefix `C-a`; popup bindings: `o`=opencode, `g`=gemini, `T`=empty        |
| `aerospace/`          | AeroSpace WM       | Replaced yabai + amethyst                                                |
| `yazi/`               | Yazi file manager  | Custom linemode `size_and_mtime` in `init.lua`                           |
| `lazygit/`            | Lazygit            | Full Catppuccin theme; `Ctrl+T` opens `nvim -c "DiffviewOpen"`           |
| `television/`         | `tv` fuzzy finder  | Shell integration: `Ctrl+T` autocomplete, `Ctrl+R` history               |
| `git/`                | Git                | delta pager; pull with rebase; vimdiff via `nvim -d`                     |
| `vscode/`             | VS Code            | Symlinked into `~/Library/Application Support/Code/User/`                |
| `marta/`              | Marta file manager | Symlinked into `~/Library/Application Support/org.yanex.marta/`          |
| `qmk-via/`            | Keychron K7 Pro    | Keyboard layout JSON only; not auto-applied                              |
| `alfred/`, `raycast/` | Alfred / Raycast   | Config exports; not auto-applied by dotbot                               |

Unused/archived: `amethyst/`, `skhd/`, `yabai/`, `zellij/`, `rectangle/`.

## Neovim (LazyVim)

- Plugin spec files live in `nvim/lua/plugins/`
- Disabled plugins use `if true then return {} end` at the top (see `dap.lua`,
  `nvim-cmp.lua`, `image.lua`, `dashboard.lua`)
- `lazyvim.json` controls LazyVim extras (source of truth for enabled extras,
  not `lua/` files)
- Lua formatter: **StyLua** — 2-space indent, 120-col width (`nvim/stylua.toml`)
- LSP/formatter/linter installs managed via Mason in
  `nvim/lua/plugins/lsp-config.lua`

## Zsh conventions

- `cd` is aliased to `z` (zoxide) — literal `cd` won't work in shell unless
  escaped
- Plugin manager: **Zinit** (auto-installs itself on first run)
- `y` function wraps yazi and changes directory on exit
- `fzf-tab` is used for completions — `Ctrl+T` is bound to `tv` (television),
  not raw fzf
- vi-mode is on; `ESC` to normal mode, starts in insert mode

## Color theme

Catppuccin **Macchiato** everywhere (Neovim, Ghostty, Kitty, tmux, bat, lazygit,
oh-my-posh, yazi, television, ncspot). VSCode uses Catppuccin Mocha. Don't
introduce themes that conflict with this palette.

## Git config notes

- `pull.rebase = true` — pulls always rebase
- `fetch.prune = true` — remote-tracking branches are pruned automatically
- Delta is the pager; `git log` and diffs render with delta

## What does NOT exist here

- No tests, no CI, no pre-commit hooks
- No `Makefile`, `justfile`, `package.json`, or task runner
- No `opencode.json` or other AI instruction files besides this one
- Dotbot is a git submodule, **not** installed via Homebrew (README has an open
  todo to change this — do not act on it unless asked)
