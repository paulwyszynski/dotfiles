# CLAUDE.md

## What this repo is

Personal macOS dotfiles for Paul Wyszynski, managed with **Dotbot** (git
submodule at `dotbot/`). No CI, no tests, no build step, no Makefile.

Open work items live in `TODO.md` (each entry has concrete steps).

## Bootstrap

```zsh
./install          # syncs dotbot submodule, then runs dotbot with install.conf.yaml
brew bundle        # install/update all packages (run from repo root, uses ./Brewfile)
```

`install` must be run from the repo root; it uses `BASH_SOURCE[0]` to find
itself.

Dotbot phases in `install.conf.yaml`: `clean` → `create` → `link` → `shell`
(runs `setup_homebrew.sh`, `setup_zsh.sh`, `setup_zoxide.sh` in order).

**Do not run `./install` yourself.** It is a fresh-machine bootstrap and its
`clean`/`relink` phases rewrite links across `~`. To add a single new dotfile,
edit `install.conf.yaml` for the record and create that one symlink by hand.

## Adding or changing symlinks

Edit `install.conf.yaml` — the `link:` section is the canonical map. Whole
directories can be linked (e.g. `nvim/`, `ghostty/`, `yazi/`); individual files
are used for tools that don't support XDG config dirs well.

## Package management

Add packages to `Brewfile`. Then run `brew bundle`. Commented-out entries
(`zellij`, `yabai`, `skhd`, `amethyst`, etc.) are intentionally unused
replacements — don't re-enable them.

## Directory ownership

| Directory             | Tool               | Notes                                                                                        |
| --------------------- | ------------------ | -------------------------------------------------------------------------------------------- |
| `nvim/`               | Neovim (LazyVim)   | Lua config; entry `init.lua` → `config.lazy`                                                 |
| `zsh/`                | Zsh                | `zshrc` (plugins, aliases, functions), `zshenv` (only `exists()` helper)                     |
| `bash/`               | Bash               | `bashrc` only; fallback shell                                                                |
| `ghostty/`            | Ghostty terminal   | Primary terminal; GLSL cursor shader in `shaders/`                                           |
| `kitty/`              | Kitty terminal     | Secondary; `kitty-scrollback.nvim` integration                                               |
| `tmux/`               | tmux               | Prefix `C-a`; popups: `o`, `g`=gemini, `T`=empty; `scripts/` powers conditional status pills |
| `aerospace/`          | AeroSpace WM       | Replaced yabai + amethyst                                                                    |
| `yazi/`               | Yazi file manager  | Custom linemode `size_and_mtime` in `init.lua`                                               |
| `lazygit/`            | Lazygit            | Full Catppuccin theme; `Ctrl+T` opens `nvim -c "DiffviewOpen"`                               |
| `television/`         | `tv` fuzzy finder  | Shell integration: `Ctrl+T` autocomplete, `Ctrl+R` history                                   |
| `git/`                | Git                | delta pager; pull with rebase; vimdiff via `nvim -d`                                         |
| `bat/`                | bat pager          | `bat.conf` + Catppuccin themes in `themes/`                                                  |
| `oh-my-posh/`         | oh-my-posh prompt  | Single `catppuccin.omp.toml`                                                                 |
| `prettier/`           | Prettier           | Global `~/.prettierrc.yaml`                                                                  |
| `ncspot/`             | ncspot (Spotify)   | `config.toml` + cached `userstate.cbor`                                                      |
| `herdr/`              | Herdr              | Single `config.toml`                                                                         |
| `mole/`               | Mole               | Synced state/prefs                                                                           |
| `claude/`             | Claude Code        | See "Claude Code setup" below                                                                |
| `copilot/`            | GitHub Copilot CLI | Linked into `~/.copilot/`: instructions + `mcp-config.json`                                  |
| `agents/`             | Legacy skills      | Linked to `~/.agents/`; not read by Claude Code — see below                                  |
| `vscode/`             | VS Code            | Symlinked into `~/Library/Application Support/Code/User/`                                    |
| `marta/`              | Marta file manager | Symlinked into `~/Library/Application Support/org.yanex.marta/`                              |
| `idea-ide/`           | JetBrains IDEs     | `ideavimrc` → `~/.ideavimrc`                                                                 |
| `qmk-via/`            | Keychron K7 Pro    | Keyboard layout JSON only; not auto-applied                                                  |
| `nuphy/`, `oryx/`     | Other keyboards    | Layout exports (NuPhy Air75 v3, ZSA Voyager); not auto-applied                               |
| `alfred/`, `raycast/` | Alfred / Raycast   | Config exports; not auto-applied by dotbot                                                   |
| `vimium/`             | Vimium browser ext | CSS + options JSON; manual import                                                            |
| `android-studio/`     | Android Studio     | `settings.zip`; manual import                                                                |
| `Xcode/`              | Xcode              | Themes + keybindings; manual install                                                         |
| `zen/`                | Zen Browser        | Extensions + mods; manual                                                                    |

Unused/archived (kept for reference, do not re-enable): `amethyst/`, `skhd/`,
`yabai/`, `zellij/`, `rectangle/`.

## Claude Code setup

This file, `CLAUDE.md`, is the single source of truth for AI coding agents in
this repo. Claude Code loads it automatically; don't duplicate it into
`AGENTS.md`, `.cursorrules`, or per-tool files.

`claude/` holds the user-level Claude Code config, symlinked into `~/.claude/`:

| Path                           | Links to                                           |
| ------------------------------ | -------------------------------------------------- |
| `claude/settings.json`         | `~/.claude/settings.json`                          |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh`                  |
| `claude/plugins/*.json`        | `~/.claude/plugins/`                               |
| `claude/memory/`               | `~/.claude/projects/-Users-paule--dotfiles/memory` |

Only the two `plugins/*.json` manifests are tracked; the plugin cache and
marketplace checkouts under `~/.claude/plugins/` are machine state, not
dotfiles.

`claude/memory/` is Claude Code's auto-memory for _this_ repo — one fact per
file, indexed by `MEMORY.md`. It is versioned deliberately; keep the index line
and the memory file in sync when editing.

### Skills

`agents/skills/` is a leftover from the previous opencode setup. Claude Code
loads user skills from `~/.claude/skills/` only, so nothing in `agents/` is
active — leave it alone unless it's being migrated or deleted on purpose.

## Tool preferences for agents working in this repo

- Search: `rg` over `grep`, `fd` over `find`
- View: `bat` over `cat` for human-facing output; raw `cat` fine for piping
- Edits: prefer in-place edits over rewrites; respect existing file style
- Never touch `dotbot/` (pinned submodule) or generated state
  (`ncspot/userstate.cbor`, `.ruby-lsp/`)
- Commits: Conventional Commits

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

## tmux status extras

Custom status-bar segments use the Catppuccin v2 custom-module API
(`utils/status_module.conf`). Backing scripts live in `tmux/scripts/`. Each
script must exit silently (empty output) on any failure and cache external API
calls in `$TMPDIR` so status refreshes stay cheap.

`status-interval` is set to `15`s.

### Active segments

| Module    | Script                        | Visibility                                    |
| --------- | ----------------------------- | --------------------------------------------- |
| `copilot` | `scripts/copilot-ai-usage.sh` | opencode running (machine-wide) + `gh` auth'd |

`copilot` shows GitHub Copilot premium-request usage as `<used>/<entitlement>`
(matches the counter on github.com Copilot settings). Backed by
`gh api /copilot_internal/user` + `jq`. Gated by `ps -axo ucomm=` matching
`^opencode` (any tmux session, popup, or outside tmux — the process name is
`opencode.exe` on macOS, and macOS `pgrep` can't see the process at all, so
don't use `pgrep` or `pane_current_command`). Cache TTL 60s → at most one API
call (or failed attempt) per minute; chip disappears when opencode exits or `gh`
is logged out.

Note: this gate and the `prefix + o` popup still target opencode, which the repo
has otherwise moved away from. See `TODO.md`.

### Adding a new status segment

1. Drop script in `tmux/scripts/<name>.sh` (exit empty on failure, `chmod +x`).
2. In `tmux.conf`, AFTER `run '~/.tmux/plugins/tpm/tpm'`:

   ```tmux
   set-environment -gh MODULE_NAME "<name>"
   set -g  "@catppuccin_<name>_icon"  "<nf-icon>"
   set -gF "@catppuccin_<name>_color" "#{E:@thm_<color>}"
   run-shell 'd=$(dirname "$(readlink -f "$HOME/.tmux.conf")"); \
     tmux set -g "@catppuccin_<name>_text" "##($d/scripts/<name>.sh)"'
   source-file ~/.tmux/plugins/tmux/utils/status_module.conf
   ```

   Then add `#{E:@catppuccin_status_<name>}` to `status-right`.

   Use `set-environment -gh`, NOT `%hidden`: `%hidden` applies at config parse
   time, but `run tpm` executes afterwards and catppuccin's module loading
   overwrites `MODULE_NAME` — the builder would then rebuild the wrong module.
   `setenv -gh` is a command, so it runs in order right before `source-file`.

   The `run-shell`/`readlink` dance is required because `#{d:current_file}`
   resolves through the `~/.tmux.conf` symlink and points at `$HOME` instead of
   the dotfiles repo. `##(...)` escapes the format so tmux stores the literal
   `#(...)` for status-bar expansion.

## What does NOT exist here

- No tests, no CI, no pre-commit hooks
- No `Makefile`, `justfile`, `package.json`, or task runner
- Dotbot is a git submodule, **not** installed via Homebrew (`TODO.md` has an
  open item to change this — do not act on it unless asked)
