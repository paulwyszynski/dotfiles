# TODO

## Dotbot: remove submodule, install via Homebrew

Dotbot is available as `brew install dotbot`. Removing the submodule simplifies
the repo and removes the `git submodule update` step from `install`.

Steps:

1. `brew install dotbot` (add to `Brewfile` first, run `brew bundle`)
2. Remove the submodule:
   ```zsh
   git submodule deinit -f dotbot
   git rm -f dotbot
   rm -rf .git/modules/dotbot
   ```
3. Delete `.gitmodules` (or just the `[submodule "dotbot"]` stanza if other
   submodules exist)
4. Rewrite `install` to call the Homebrew-installed binary:
   ```zsh
   #!/usr/bin/env zsh
   set -e
   BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
   dotbot -d "${BASEDIR}" -c "${BASEDIR}/install.conf.yaml" "$@"
   ```
5. Run `./install` and verify all symlinks are applied correctly

## Fix remaining kitty symlinks

`kitty/` has three individual file links in `install.conf.yaml` instead of one
directory link. Ghostty, television, yazi, etc. already use the whole-directory
pattern. Consolidate:

1. Change the three kitty entries in `install.conf.yaml`:

   ```yaml
   # remove these three:
   ~/.config/kitty/kitty.conf: kitty/kitty.conf
   ~/.config/kitty/current-theme.conf: kitty/current-theme.conf
   ~/.config/kitty/startup.conf: kitty/startup.conf

   # replace with:
   ~/.config/kitty/: kitty/
   ```

2. Remove `~/.config/kitty` from the `create:` block (it will be created by the
   link itself)
3. Run `./install` to relink

## Shell setup improvements in `install.conf.yaml`

Several commented-out shell tasks should be automated. Candidates worth adding
to the `shell:` block:

- **Yazi plugins/themes** (already noted in comments):
  ```yaml
  - command: ya pack -a yazi-rs/flavors:catppuccin-macchiato
  - command: ya pack -a yazi-rs/plugins:full-border
  - command: ya pack -a yazi-rs/plugins:chmod
  - command: ya pack -a yazi-rs/plugins:what-size
  ```
- **tmux plugin manager bootstrap**: install TPM if not present, then trigger
  plugin install non-interactively:
  ```zsh
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --depth 1 2>/dev/null || true
  ~/.tmux/plugins/tpm/bin/install_plugins
  ```

## Separate private vs. work config

Currently everything (including `paul.wyszynski@gmail.com`) is in a single
`git/gitconfig`. Goal: keep private config as-is, add a work overlay.

Suggested approach using `includeIf`:

1. Keep `git/gitconfig` as the personal default
2. Create `git/gitconfig-work` with work `name`/`email` only
3. Add to `git/gitconfig`:
   ```ini
   [includeIf "gitdir:~/work/"]
     path = ~/.config/git/gitconfig-work
   ```
   Adjust the `gitdir` glob to match wherever work repos live
4. Symlink `git/gitconfig-work` via `install.conf.yaml`

This avoids a separate full install profile while still keeping work commits off
the personal email.

## Automate private vs. work config selection

`omniwm/` now has `private/omniwm/` and `work/omniwm/` as full config-dir
variants (see `CLAUDE.md`'s "Private vs. work config" section), but
`~/.config/omniwm` is hand-symlinked to the right one per machine. Generalize
this so adding a profile-split tool doesn't require memorizing/repeating a
manual symlink step.

Concept:

1. **Folder convention stays opt-in.** A tool with one config stays flat
   (`<tool>/`, linked via `link:` as today) — that's the default when there's
   no split. Only tools that need two variants grow `<tool>/private/` and
   `<tool>/work/` subfolders, each a full drop-in copy of that tool's real
   config dir.
2. **One canonical profile marker.** An untracked file, e.g.
   `~/.dotfiles-profile` containing `work` or `private`, set once per machine
   (defaults to `private` if absent). Simpler and more robust than hostname
   matching (survives renames/reinstalls).
3. **A `shell:`-phase script, not a `link:` entry.** `install.conf.yaml`'s
   `link:` map is static and shared across machines (`clean: ['~']` +
   `relink: true`), so it can't express "this symlink, but only on this
   machine" — declaring one variant there would let `./install` on the other
   machine stomp its symlink. Instead add `setup_profile_links.sh` to the
   existing `shell:` phase (same pattern as `setup_homebrew.sh`/
   `setup_zsh.sh`/`setup_zoxide.sh`): it reads the profile marker and, for
   each tool folder that has both `private/` and `work/`, symlinks that
   tool's real config path to the matching variant. Tools without a `work/`
   variant are untouched and keep flowing through `link:` as now.
4. Migrate omniwm's existing hand-symlink to go through this script once it
   exists.

Adding a new profile-split tool afterward is then: create the `work/` folder +
one line in the script's tool→path map — no `install.conf.yaml` changes.

## Automate `brew bundle` from `install`

`setup_homebrew.sh` already calls `brew bundle --verbose`, but `brew bundle` is
not run on subsequent `./install` calls unless Homebrew is missing. Consider
always calling `brew bundle` (or `brew bundle check || brew bundle`) from
`setup_homebrew.sh` so a single `./install` is truly idempotent end-to-end.

## Retire remaining opencode references

The repo moved to Claude Code, but two places still target opencode:

- `tmux/tmux.conf:100` — `prefix + o` popup runs `opencode`
- `tmux/scripts/copilot-ai-usage.sh:32` — the status pill only renders while an
  `^opencode` process is running, so it never shows now

Decide per item: repoint the popup at `claude`, and either change the gate in
`copilot-ai-usage.sh` or drop the pill along with its block at the bottom of
`tmux.conf`.

Also unresolved: `agents/skills/` is still linked to `~/.agents/` but Claude
Code only reads `~/.claude/skills/`, so those skills are inert. Migrate or
delete them.

## Install MacFuse and SSHFS via Homebrew

[macFUSE](https://macfuse.github.io/)
