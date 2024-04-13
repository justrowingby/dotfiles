#!/usr/bin/env bash
set -u
echo "Using nixpkgs-dev at $NIXPKGS_DEV"
nix run -f . profile.switch --arg nixpkgs-dev "$NIXPKGS_DEV"
