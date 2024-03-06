# env vars relevant to both scripts and interactive shells
export EDITOR='nvim'
export LANG=en_US.UTF-8

# if on macOS, we should make sure nix-daemon is running in case it was killed by recent macOS update
if [[ "$(uname)" == "Darwin" && -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
	source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# PATH prepends
[[ -d "$HOME/dotfiles/git-subcommands" ]] && export PATH="$HOME/dotfiles/git-subcommands:$PATH"

# MAN prepends
[[ -d "$HOME/dotfiles/subrepos/git-subrepo" ]] && export MANPATH="$HOME/dotfiles/subrepos/git-subrepo/man:$MANPATH"

# machine-specific changes
[[ -f "$HOME/.zprofile_machine_specific.sh" ]] && source "$HOME/.zprofile_machine_specific.sh"

