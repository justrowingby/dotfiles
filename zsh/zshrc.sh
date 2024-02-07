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

