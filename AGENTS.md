# AGENTS.md

## Response style

Terse like caveman. Technical substance exact. Only fluff die. Drop: articles,
filler (just/really/basically), pleasantries, hedging. Fragments OK. Short
synonyms. Code unchanged. Pattern: [thing] [action] [reason]. [next step].
ACTIVE EVERY RESPONSE. No revert after many turns. No filler drift.
Code/commits/PRs: normal. Off: "stop caveman" / "normal mode".

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

| Directory             | Tool               | Notes                                                                                                    |
| --------------------- | ------------------ | -------------------------------------------------------------------------------------------------------- |
| `nvim/`               | Neovim (LazyVim)   | Lua config; entry `init.lua` → `config.lazy`                                                             |
| `zsh/`                | Zsh                | `zshrc` (plugins, aliases, functions), `zshenv` (only `exists()` helper)                                 |
| `bash/`               | Bash               | `bashrc` only; fallback shell                                                                            |
| `ghostty/`            | Ghostty terminal   | Primary terminal; GLSL cursor shader in `shaders/`                                                       |
| `kitty/`              | Kitty terminal     | Secondary; `kitty-scrollback.nvim` integration                                                           |
| `tmux/`               | tmux               | Prefix `C-a`; popups: `o`=opencode, `g`=gemini, `T`=empty; `scripts/` powers conditional status segments |
| `aerospace/`          | AeroSpace WM       | Replaced yabai + amethyst                                                                                |
| `yazi/`               | Yazi file manager  | Custom linemode `size_and_mtime` in `init.lua`                                                           |
| `lazygit/`            | Lazygit            | Full Catppuccin theme; `Ctrl+T` opens `nvim -c "DiffviewOpen"`                                           |
| `television/`         | `tv` fuzzy finder  | Shell integration: `Ctrl+T` autocomplete, `Ctrl+R` history                                               |
| `git/`                | Git                | delta pager; pull with rebase; vimdiff via `nvim -d`                                                     |
| `bat/`                | bat pager          | `bat.conf` + Catppuccin themes in `themes/`                                                              |
| `oh-my-posh/`         | oh-my-posh prompt  | Single `catppuccin.omp.toml`                                                                             |
| `prettier/`           | Prettier           | Global `~/.prettierrc.yaml`                                                                              |
| `ncspot/`             | ncspot (Spotify)   | `config.toml` + cached `userstate.cbor`                                                                  |
| `mole/`               | Mole               | Synced state/prefs                                                                                       |
| `agents/`             | AI agents          | Linked to `~/.agents`; holds shared skills used by opencode/claude                                       |
| `copilot/`            | GitHub Copilot CLI | Linked into `~/.copilot/`: instructions + `mcp-config.json`                                              |
| `vscode/`             | VS Code            | Symlinked into `~/Library/Application Support/Code/User/`                                                |
| `marta/`              | Marta file manager | Symlinked into `~/Library/Application Support/org.yanex.marta/`                                          |
| `idea-ide/`           | JetBrains IDEs     | `ideavimrc` → `~/.ideavimrc`                                                                             |
| `qmk-via/`            | Keychron K7 Pro    | Keyboard layout JSON only; not auto-applied                                                              |
| `nuphy/`, `oryx/`     | Other keyboards    | Layout exports (NuPhy Air75 v3, ZSA Voyager); not auto-applied                                           |
| `alfred/`, `raycast/` | Alfred / Raycast   | Config exports; not auto-applied by dotbot                                                               |
| `vimium/`             | Vimium browser ext | CSS + options JSON; manual import                                                                        |
| `android-studio/`     | Android Studio     | `settings.zip`; manual import                                                                            |
| `Xcode/`              | Xcode              | Themes + keybindings; manual install                                                                     |
| `zen/`                | Zen Browser        | Extensions + mods; manual                                                                                |

Unused/archived (kept for reference, do not re-enable): `amethyst/`, `skhd/`,
`yabai/`, `zellij/`, `rectangle/`.

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

| Module    | Script                        | Visibility                                        |
| --------- | ----------------------------- | ------------------------------------------------- |
| `copilot` | `scripts/copilot-ai-usage.sh` | Only while `opencode` runs in current tmux server |

`copilot` shows GitHub Copilot premium-request usage as `<used>/<entitlement>`
(matches the counter on github.com Copilot settings). Backed by
`gh api /copilot_internal/user` + `jq`. Cache TTL 60s → at most one API call per
minute, and only while opencode is alive.

### Adding a new status segment

1. Drop script in `tmux/scripts/<name>.sh` (exit empty on failure, `chmod +x`).
2. In `tmux.conf`, before `status-right` is set:

   ```tmux
   %hidden MODULE_NAME="<name>"
   set -g  "@catppuccin_${MODULE_NAME}_icon"  "<nf-icon>"
   set -gF "@catppuccin_${MODULE_NAME}_color" "#{E:@thm_<color>}"
   run-shell 'd=$(dirname "$(readlink -f "$HOME/.tmux.conf")"); \
     tmux set -g "@catppuccin_<name>_text" "##($d/scripts/<name>.sh)"'
   source-file ~/.tmux/plugins/tmux/utils/status_module.conf
   ```

   Then add `#{E:@catppuccin_status_<name>}` to `status-right`.

   The `run-shell`/`readlink` dance is required because `#{d:current_file}`
   resolves through the `~/.tmux.conf` symlink and points at `$HOME` instead of
   the dotfiles repo. `##(...)` escapes the format so tmux stores the literal
   `#(...)` for status-bar expansion.

## AI agent conventions

This `AGENTS.md` is the single source of truth for AI coding agents (opencode,
Claude Code, Cursor, Aider, Copilot CLI — all read `AGENTS.md` natively). Do not
duplicate it into tool-specific files (`opencode.json`, `.cursorrules`,
`CLAUDE.md`, etc.).

Related on-disk locations:

- `agents/` → linked to `~/.agents/` — shared skills (caveman, commit, review)
- `copilot/` → linked to `~/.copilot/` — Copilot CLI instructions + MCP config
- Opencode reads project `AGENTS.md` + global `~/.config/opencode/AGENTS.md` if
  present

Tool preferences for agents working in this repo:

- Search: `rg` over `grep`, `fd` over `find`
- View: `bat` over `cat` for human-facing output; raw `cat` fine for piping
- Edits: prefer in-place edits over rewrites; respect existing file style
- Never touch `dotbot/` (pinned submodule) or generated state
  (`ncspot/userstate.cbor`, `.ruby-lsp/`)
- Commits: Conventional Commits; the `caveman-commit` skill is available
  globally

## What does NOT exist here

- No tests, no CI, no pre-commit hooks
- No `Makefile`, `justfile`, `package.json`, or task runner
- Dotbot is a git submodule, **not** installed via Homebrew (README has an open
  todo to change this — do not act on it unless asked)
