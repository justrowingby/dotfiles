# env vars relevant to both scripts and interactive shells
export EDITOR='nvim'
export LANG=en_US.UTF-8

# if on macOS, we should make sure nix-daemon is running in case it was killed by recent macOS update
if [[ "$(uname)" == "Darwin" && -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
	source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

