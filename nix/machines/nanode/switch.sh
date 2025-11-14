#!/bin/sh
flakedir=$(cd "$(dirname -- "$0")" ; cd ../.. ; pwd -P)
nixos-rebuild "${1:-switch}" --flake "$flakedir#nanode" --use-remote-sudo --fast --target-host root@2600:3c0a::2000:d9ff:fe47:3f8c
