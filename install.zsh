#!/usr/bin/env zsh

echo ". ~/dev/dotfiles/zshrc" > ~/.zshrc

# Propel
touch ~/.secrets
touch ~/.android-config

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

ln -f vimrc ~/.vimrc
ln -f gitconfig ~/.gitconfig
ln -f iterm-profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/iterm-profile.json
ln -f vscode/propel/settings.json ~/Library/Application\ Support/Code/User/settings.json

. ~/.zshrc
