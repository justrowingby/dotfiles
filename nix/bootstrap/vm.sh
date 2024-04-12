#!/bin/sh
nixos-rebuild "${1:-switch}" --flake .#vm
