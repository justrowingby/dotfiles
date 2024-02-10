# oh-my-zsh configuration for interactive shells
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode disabled  # disable automatic updates
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git colored-man-pages colorize)
source $ZSH/oh-my-zsh.sh

# function definitions and aliases

# ls-like eza aliases
alias ls="eza" # ls drop-in, this *should* be fine cz any software grabbing ls from path is busted garbage.
alias la="eza -a" # ls but show hidden files
alias ld="eza -lD" # long form, only directories
alias lf="eza -lF --color=always | grep -v /" # long form, only files
alias lh="eza -dl .* --group-directories-first" # long form, only hidden files
alias ll="eza -l --group-directories-first" # long form, directories first
alias lla="eza -al --group-directories-first" # long form, lists everything with directories first
alias lls="eza -alF --color=always --sort=size" # long form, list everything sorted by size
alias lt="eza -al --sort=modified" # long form, list everything sorted by time modified
# tree-like eza aliases
# we believe 'tree' and 'eza -T' default depth being unbounded is a silly footgun, so the tree drop-in here requires a depth
alias tz='(){eza -T -L "$@"}' # nearly tree drop-in. usage is "tree depth [other eza options] [dir]". gets upset with you if $1 isn't a number.
alias tzu='(){eza -T "$@"}' # tree unbounded, becomes less of a footgun if it's not the thing you instinctively type without thinking
alias tl='(){eza -lT --group-directories-first -L "$@"}' # "what if ll but tree"
alias tla='eza -alT --group-directories-first -L "$@"' # "what if lla but tree"
# what if hitting the spacebar is suchhhh a burden
alias tz1="tz 1"
alias tz2="tz 2"
alias tz3="tz 3"
alias tl1="tl 1"
alias tl2="tl 2"
alias tl3="tl 3"
alias tla1="tla 1"
alias tla2="tla 2"
alias tla3="tla 3"

