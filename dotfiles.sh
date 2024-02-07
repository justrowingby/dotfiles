#!/usr/bin/env bash

scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

function enact_link() {
    if [[ -e "$2" && ! -L "$2" ]] ; then 
        echo "$2 exists and is not a symlink. not replacing." >&2
        return 1
    fi
    
    # "ln -sf source link" follows symlinks by default on ancient BSD (thus on macOS)
    # the fix on ancient BSD is to add -h, which doesn't exist on GNU ln bc it simply does the reasonable thing in the first place
    # thus for this to be portable we have to implement -f ourselves
    [[ -L "$2" ]] && rm "$2"
    
    ln -sv "${scriptdir}/$1" "$2"
}

mkdir -p ~/.config
enact_link git ~/.config/git
enact_link kate ~/.config/kate
enact_link zsh/zprofile.sh ~/.zprofile
enact_link zsh/zshrc.sh ~/.zshrc

