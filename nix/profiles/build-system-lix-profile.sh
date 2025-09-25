#!/usr/bin/env bash

set -eu
scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

nix --extra-experimental-features "nix-command flakes" build "$scriptdir"/..#system-lix-profile
