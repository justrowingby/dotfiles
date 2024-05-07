#!/usr/bin/env bash
nix --extra-experimental-features nix-command --extra-experimental-features flakes run .#profile.switch
