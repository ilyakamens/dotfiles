path=("/usr/local/bin" $path)
path+=("/Library/PostgreSQL/12/bin/")
path+=("/usr/local/mysql/bin")
path+=("$HOME/Library/Python/3.8/bin")
path+=("$HOME/Library/Python/3.11/bin")
path+=("$HOME/google-cloud-sdk/bin")
path+=("/usr/local/go/bin")
export PATH

export GOPATH=/usr/local/go/bin
export EDITOR=vim

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
alias tf='terraform'

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
alias cddev='cd ~/dev'
alias cddf='cd ~/dev/dotfiles'

# git
alias ga='git add'
alias gaa='git add -A'
alias gaap='git add -A --patch'
alias gap='git add --patch'
alias gau='git add -u'
alias gc='git commit'
alias gca='git commit -a'
alias gcaa='git commit -a --amend'
alias gd='git diff'
alias gdel='git branch | grep -v main | xargs git branch -D'
alias gds='git diff --staged'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpm='git co main && git pull'
alias gpr='git pull origin main --rebase'
alias gst='git status'
alias gr='git restore'
alias grim='git rebase -i main'
alias grs='git restore --staged'
alias gundo='git reset HEAD~'

alias gti='git'

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
        base=main
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
    if [[ $1 != "main" ]]; then
        branch="ilya/"
    fi

    git co "$branch$1"
}

gcob() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: gcob <branch suffix>"
        return
    fi

    git co -b "ilya/$1"
}

# Git rebase main: Set `main` as the base branch.
grm() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: grm <old branch>"
        return
    fi

    git rebase --onto main $1 $(get_git_branch)
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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pipx
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"
