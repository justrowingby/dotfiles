#!/usr/bin/env bash

set -eu
scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

nix --extra-experimental-features "nix-command flakes" run "$scriptdir"/..#bootstrap-profile.switch
sudo -i nix run "$scriptdir"/..#bootstrap-profile.pin
