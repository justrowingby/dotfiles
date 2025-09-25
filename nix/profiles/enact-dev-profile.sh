#!/usr/bin/env bash

set -eu
scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

nix --extra-experimental-features "nix-command flakes" run "$scriptdir"/..#dev-profile.switch
sudo -i nix run "$scriptdir"/..#dev-profile.pin
