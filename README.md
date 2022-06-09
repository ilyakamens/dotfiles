# dotfiles

## Installation

1. Open Terminal
2. Generate a new SSH keypair:

```
ssh-keygen
eval "$(ssh-agent -s)"
cat >~/.ssh/config <<EOL
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
EOL
```
3. [Add your new public key to your GitHub account.](https://github.com/settings/keys)
4. Clone the repository and install:

```
mkdir ~/dev
cd dev
git clone git@github.com:ilyakamens/dotfiles.git
cd dotfiles
./install.zsh
```

5. [Configure iTerm2 backup preferences](https://gitlab.com/gnachman/iterm2/-/wikis/back-up-preferences) and quit iTerm2.
6. Discard iTerm2 default settings:

```
git restore com.googlecode.iterm2.plist
```
