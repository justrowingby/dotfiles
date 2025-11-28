#!/usr/bin/env bash

scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

function default_link() {
    if [[ -e "$2" ]] ; then 
	# something already exists there. no need to create a default.
        return 0
    fi

    ln -sv "${scriptdir}/$1" "$2"
    
}

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

function rm_broken_link() {
    if [[ -e "$1" ]] ; then 
        echo "$1 exists, so is not a broken symlink. not deleting." >&2
        return 1
    fi
    if [[ ! -L "$1" ]] ; then
	# there is no link to remove! yay! probably re-entrant case.
        return 0
    fi
    
    rm "$1" && echo "deleted broken symlink $1"
}

function mk_config_dir_for_file() {
    mkdir -p "$1.d"
    if [[ -f "$1" ]] ; then
        if [[ -L "$1" ]] ; then
	    echo "$1 exists and is a symlink. not moving into $1.d in case it is a relative path." >&2
	    return 1
	fi
	mv "$1" "$1.d"
	echo "moved $1 to $1.d/"
    fi
}

mkdir -p ~/.config
cd "${scriptdir}"
enact_link git ~/.config/git
enact_link kate ~/.config/kate
enact_link kitty ~/.config/kitty
enact_link fish ~/.config/fish
enact_link zsh/zprofile.sh ~/.zprofile
enact_link zsh/zshrc.sh ~/.zshrc
enact_link bin ~/.config/bin
rm_broken_link ~/.oh-my-zsh
rm_broken_link kitty/kittyshell
default_link bin/shell/unchosen-shell-warning.bash bin/shell/shell
mk_config_dir_for_file ~/.config/Brewfile

