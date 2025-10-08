set -gx EDITOR nvim
set -gx PAGER less
set -gx LANG en_US.UTF-8
fish_add_path --path $HOME/dotfiles/sh-commands
fish_add_path -a --path /opt/homebrew/bin
fish_add_path --path $HOME/.toolbox/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    # tried and true
    abbr --add gits git status
    abbr --add gita git add
    abbr --add gitc git commit
    abbr --add gitm git commit -m

    # new ones
    abbr --add gitca git commit --amend
    abbr --add gitad git add .

    # in case --global points to a machine-specific ~/.gitconfig
    abbr --add --position command gitconfig "git config --file ~/.config/git/config"

    # gnu ls
    abbr --add lltime gls -l -t -h --full-time

    # eza
    abbr --add lz eza
    abbr --add tz eza -T -L
    abbr --add tz2 eza -T -L 2
    abbr --add tz3 eza -T -L 3
end
