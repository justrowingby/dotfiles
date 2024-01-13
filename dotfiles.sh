#!/bin/sh

scriptdir=$(realpath "$(dirname "$0")")

function do_dir() {
    ln -sfTv "${scriptdir}/${1}" "${2}"
}

mkdir -p ~/.config
do_dir git ~/.config/git
do_dir kate ~/.config/kate
