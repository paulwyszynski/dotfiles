#!/bin/bash

# TODO: Keep an eye out for a different `--no-quarantine` solution.
# Currently, you can't do `brew bundle --no-quarantine` as an option.
# It's currently exported in zshrc:
# export HOMEBREW_CASK_OPTS="--no-quarantine"
# https://github.com/homebrew/homebrew-bundle/issues/474

exists() {
  command -v "$1" >/dev/null 2>&1
}

printf "\n<<< Starting Homebrew Setup >>>\n"

if exists brew; then
  printf "\nHomebrew is already installed. Skipping...\n"
else
  printf "\nInstalling Homebrew...\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf "\n<<< Insalling or updating packages >>>\n"

brew bundle --verbose
