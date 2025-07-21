#!/usr/bin/env bash

scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

nix --extra-experimental-features "nix-command flakes" build "$scriptdir"/..#system-lix-profile
