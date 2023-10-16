#!/usr/bin/env zsh

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools here
brew install rectangle
brew install iterm2
brew install zsh-syntax-highlighting
brew install neovim
brew install neofetch
brew install ripgrep
brew install git-flow
brew install git-delta
brew install tree
brew install zellij
brew install fff
brew install htop
brew install btop
brew install spotify-tui
brew install lazygit
brew install exa
brew install httpie
brew install bat
brew install fd
brew install openjdk@17
brew install cmatrix

# Install applications here. Avoid Gate Keeper restrictions with --no-quarantine flag.
brew install --cask --no-quarantine brave-browser
brew install --cask --no-quarantine android-studio
brew install --cask --no-quarantine appcleaner
brew install --cask --no-quarantine alfred
brew install --cask --no-quarantine amethyst
brew install --cask --no-quarantine obsidian
brew install --cask --no-quarantine fork
brew install --cask --no-quarantine clockify
