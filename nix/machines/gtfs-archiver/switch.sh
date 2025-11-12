#!/usr/bin/env bash

args=(
	--target-host root@gtfs-archiver
	--use-substitutes
	--use-remote-sudo
	--flake .#gtfs-archiver
	--fast
)

op="${1:-switch}"
shift

nixos-rebuild "$op" "$@" "${args[@]}"
