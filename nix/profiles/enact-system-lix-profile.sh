#!/usr/bin/env bash

set -eu
scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)

sudo nix --extra-experimental-features "nix-command flakes" run "$scriptdir"/..#system-lix-profile.switch

if type systemctl >/dev/null 2>&1 ; then
  sudo systemctl daemon-reload && sudo systemctl restart nix-daemon
fi

if type launchctl >/dev/null 2>&1 ; then
  sudo launchctl stop system/org.nixos.nix-daemon
  sudo launchctl enable system/org.nixos.nix-daemon
  sudo launchctl kickstart -k system/org.nixos.nix-daemon
fi
