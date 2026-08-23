---
name: feedback-never-run-install-script
description: Never run ./install (dotbot) in the dotfiles repo except on a fresh macOS setup
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d9d977d5-d3a8-4096-9cb5-4a4f3bd155c9
  modified: 2026-08-23T15:17:03.893Z
---

Never run `./install` in `/Users/paule/.dotfiles` unless explicitly setting up a brand-new macOS machine.

**Why:** `./install` runs dotbot (symlinking per `install.conf.yaml`) *and* the `shell:` section, which executes `setup_homebrew.sh`, `setup_zsh.sh`, and `setup_zoxide.sh`. On an already-configured machine this is unnecessary and risks side effects (relinking, running setup scripts) the user didn't ask for. It's intended strictly for fresh-machine bootstrap.

**How to apply:** When adding a new dotfile to track (e.g. a new `link:` entry in `install.conf.yaml`), do NOT run `./install` to materialize the symlink. Instead, manually create the individual symlink for just that file with `ln -sf` (after copying the original content into the repo and removing the original), so only the intended file changes. Leave the rest of the install pipeline (homebrew/zsh/zoxide setup, full relink of everything) untouched.
