# why does dotfiles/bin need to exist

#### a story of using fish on macOS

there's a funny problem i have where...
- when bootstrapping these dotfiles on macOS,
        i very much do not want to have to go mutate /etc/shells as sudo
        to add a homebrew or nix-profile path to it
- macOS does not include fish in /bin and so also not in /etc/shells
- i run fish
==> congrats to me, we cannot `chsh` to fish
    because it's not available for choosing from /bin

what about $SHELL ?
on macOS, launchd launches GUI apps with an env
that is _not_ obtained from a login shell,
but instead only launchd.
there is a CLI which you can call to add stuff to this env.
however its use is not supported by Apple
and it forgets everything on every restart.

there is no other way to configure the env.

so your terminal emulator will be inheriting the PATH
"/usr/bin:/bin:/usr/sbin:/sbin"
and there's not anything you can really do about it

so evidently i need to, in individual terminal emulator's config,
provide a filesystem path to a launchable shell.

but again i would not like to synchronize via the dotfiles
any particular pkg manager's chosen place to put `fish`.

hm.
i'm very glad symlinks exist and are generally well-supported.

dotfiles/bin/unchosen-shell-warning.bash is synced over git as a dinky script
which warns you that it hasn't been replaced with a symlink to a shell,
and then dumps you into `sh`

and dotfiles.sh creates dotfiles/bin/shell as a link to that script
if it is not already a link to something else

it is named in .gitignore so that you can replace it with a symlink to a fish location
(probably the homebrew one or ~/.nix-profile/bin/fish )
without any complaints from git that you aren't upstreaming a single-machine config.

this file was previously dotfiles/kitty/kittyshell (fish in kitty mouf)
but then i wanted to do the same thing for wezterm,
bc im very excited about wezterm nightly getting tmux -CC support,
so ive refactored it out for the two to share.
