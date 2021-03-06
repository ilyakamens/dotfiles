path=("/usr/local/bin" $path)
path+=("/Library/PostgreSQL/12/bin/")
path+=("/usr/local/mysql/bin")
path+=("/Users/ilyakamens/Library/Python/3.8/bin")
path+=("~/google-cloud-sdk/bin")
path+=("/usr/local/go/bin")
export PATH

export GOPATH=/usr/local/go/bin

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
alias gpm='git co master && git pull'
alias gundo='git reset HEAD~'
alias gdel='git branch | grep -v master | xargs git branch -D'
alias grim='git rebase -i master'
alias gcaa='git commit -a --amend'

alias gti='git'

get_git_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}

gpu() {
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ $# -eq 1 ]]; then
        branch="$1"
    fi
    git push -u origin "$branch"
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

    git add -A
    git commit --fixup $1
    GIT_EDITOR=true git rebase --interactive --autosquash $base
}

gco() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: gco <branch suffix>"
        return
    fi

    branch=""
    if [[ $1 != "master" ]]; then
        branch="ilya-"
    fi

    git co "$branch$1"
}

gcob() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: gcob <branch suffix>"
        return
    fi

    git co -b "ilya-$1"
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
