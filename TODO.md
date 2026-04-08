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

## Automate `brew bundle` from `install`

`setup_homebrew.sh` already calls `brew bundle --verbose`, but `brew bundle` is
not run on subsequent `./install` calls unless Homebrew is missing. Consider
always calling `brew bundle` (or `brew bundle check || brew bundle`) from
`setup_homebrew.sh` so a single `./install` is truly idempotent end-to-end.
