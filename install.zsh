#!/usr/bin/env zsh

# https://gitlab.com/gnachman/iterm2/-/wikis/back-up-preferences

echo ". ~/dev/dotfiles/zshrc" > ~/.zshrc

# Propel
touch ~/.secrets
touch ~/.android-config

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ln -f vimrc ~/.vimrc
ln -f gitconfig ~/.gitconfig
ln -f iterm-profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/iterm-profile.json
ln -f vscode/propel/settings.json ~/Library/Application\ Support/Code/User/settings.json

brew bundle

. ~/.zshrc
