#!/usr/bin/env bash

SECOND_HIGHEST_NUMBER=$(echo /nix/var/nix/profiles/default-*-link | grep -Eo '[0-9]+' | sort -n -r | head -n 2 | tail -n 1)
sudo /nix/var/nix/profiles/default-"$SECOND_HIGHEST_NUMBER"-link/bin/nix-env --rollback --profile /nix/var/nix/profiles/default

if type systemctl >/dev/null 2>&1 ; then
  sudo systemctl daemon-reload && sudo systemctl restart nix-daemon
fi

if type launchctl >/dev/null 2>&1 ; then
  sudo launchctl stop system/org.nixos.nix-daemon
  sudo launchctl enable system/org.nixos.nix-daemon
  sudo launchctl kickstart -k system/org.nixos.nix-daemon
fi
