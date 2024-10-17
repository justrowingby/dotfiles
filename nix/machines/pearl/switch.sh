#!/bin/sh
flakedir=$(cd "$(dirname -- "$0")" ; cd ../.. ; pwd -P)
nixos-rebuild "${1:-switch}" --flake "$flakedir#pearl"
