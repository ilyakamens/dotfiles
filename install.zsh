# TODO: Use soft links instead 

cp vimrc ~/.vimrc
cp gitconfig ~/.gitconfig

# Can't use link for iTerm settings; results in error
cp iterm-profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles
ln -svf vscode/propel/settings.json ~/Library/Application\ Support/Code/User
