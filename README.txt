# dotfiles by rowenna

this is extremely a work in progress. i'm fairly new to this. 
each program gets its own dir containing dotfiles. currently all are linked into HOME dir (not XDG_CONF, maybe i'll fix that later) by dotfiles.sh.

there is also a nix directory, which ideally can be completely ignored if you don't want to use nix.

i'm using nix as my package manager on both linux and macOS for terminal-based programs pretty much just need dotfiles to function desirably. 
GUI apps by contrast need slightly more power than "the files exist in the nix store and are referenced in your path", ie you sure can `nix-shell -p kitty ; kitty` yet there is more needed to make that same kitty ref appear amongst your Applications, and the work to do this is very different between macOS and linux. to solve this problem i _could_ embrace nixOS modules everywhere w nix-darwin, but instead i'm going w a simpler and more portable approch: just don't universally solve that problem w nix.
so, anything which would be a pain to install declaratively without nixOS modules, are expected to be installed imperatively on non-nixOS via that system's preferred imperative package manager (brew, apt, yum, etc...).

