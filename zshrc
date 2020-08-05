PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
PATH=/usr/local/Cellar/python/2.7.14_2/bin:$PATH
PATH=/usr/local/lib/python2.7/site-packages:$PATH
PATH=/usr/local/bin:$PATH
PATH=~/Library/Python/2.7/bin:$PATH
PATH=~/node_modules/.bin:$PATH
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="/Library/PostgreSQL/12/bin/:$PATH"
PATH="/usr/local/mysql/bin:$PATH"
PATH="/Users/ilyakamens/Library/Python/3.8/bin:$PATH"
PATH=$PATH:~/google-cloud-sdk/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# prevent path from expanding/duplicating
# when zshrc is sourced
typeset -U PATH path

# zsh
# don't highlight pasted text
zle_highlight+=(paste:none)
# use modern completion system (highlight tab completion)
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
# removed '-' '/' '_' '?' '.'
export WORDCHARS='*[]~=&;!#$%^(){}<>'

# misc
alias c='clear'
alias resetaudio='sudo kextunload /System/Library/Extensions/AppleHDA.kext && sudo kextload /System/Library/Extensions/AppleHDA.kext'

# history
HISTFILE=~/.history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# share history between tabs/sessions
setopt share_history

# zshrc
alias zshrc='vim ~/.zshrc'
alias rzshrc='vim ~/dev/dotfiles/zshrc'
alias rfrsh='source ~/.zshrc'
alias cddotfiles='cd ~/dev/dotfiles'

# git
alias gst='git status'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='git pull origin master --rebase'
alias gundo='git reset HEAD~'
alias gdel='git branch | grep -v master | xargs git branch -D'
gpu() {
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ $# -eq 1 ]]; then
        branch="$1"
    fi
    git push -u origin "$branch"
}
get_git_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}
gg() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: 'gg foo bar baz' searches for 'foo' and excludes dirs/files 'bar' and 'baz'"
        return
    fi
    exclude="-- ."
    for arg in "${@:2}"; do
        exclude="$exclude ':!$arg'"
    done
    eval "git grep --break --heading --line-number $1 $exclude"
}
gfix() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: gfix <commit hash>"
        return
    fi

    base=$2
    if [[ -z "$base" ]]; then
        base=master
    fi

    git commit --fixup $1
    git rebase --interactive $base
}

# propel
source ~/dev/dotfiles/propelrc

# misc
function activate() {
    source "$HOME/.virtualenvs/$1/bin/activate"
}

# alias resetting color in prompt for readability
eval R='%{$reset_color%}'
# perform parameter expansion, command substitution and arithmetic expansion in prompts
setopt PROMPT_SUBST
# custom prompt
export PROMPT='%n %F{magenta}%0~%f %F{yellow}%*%f %F{cyan}($(get_git_branch))%f $ '
# include the hostname if this is a remote host
test -n "$SSH_CLIENT" && PROMPT="%m:$PROMPT"

# fuzzy finder (https://github.com/junegunn/fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
