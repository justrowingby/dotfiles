#!/usr/bin/env bash

# Check if the script is run with root privs (EUID 0)
if [[ $EUID == 0 ]] ; then
  echo "This script must not be run with root priveleges."
  exit 1
fi

nix-env --rollback
