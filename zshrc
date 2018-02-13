PATH=/usr/local/bin:$PATH
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

# git
alias gst='git status'
alias gp='git push'
alias gpf='git push -f'
alias gpr='git pull origin master --rebase'
alias gundo='git reset HEAD~'
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

# propel
export ANDROID_HOME="/usr/local/opt/android-sdk"
export ANDROIDSDK="/usr/local/opt/android-sdk"
export ANDROIDNDK="/usr/local/opt/android-ndk"
export ANDROIDAPI="15"  # Minimum API version your application require
export ANDROIDNDKVER="r14"  # Version of the NDK you installed
alias ftests='./docker-shell pytest'
alias fcov='open htmlcov/index.html'
alias ttests='./docker-shell trial'
alias tcov='open ebtbalance/htmlcov/index.html'
alias listroutes='./docker-shell manage list_routes'
alias tf='terraform'
alias venvserver='source ~/.virtualenvs/freshebt-server/bin/activate'
alias venvboto3moto='source ~/.virtualenvs/boto3moto/bin/activate'
alias f8='flake8'
alias cdserver='cd ~/propel/freshebt-server'
alias cdapp='cd ~/propel/freshebt-app'
alias listdevices='adb devices'
alias phonelogs='adb logcat'
source ~/.secrets

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
