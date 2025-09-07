pkgs:
with pkgs; [
  coreutils-prefixed
  file
  fish
  git # you'll immediately need git on a new machine
  htop
  neovim # you'll immediately need an editor on a new machine
  nil # you'll immediately want a nix LSP on a new machine
  nixfmt-rfc-style # you'll immediately want a nix formatter on a new machine
  openssh # ensure macOS profiles can use non-busted ssh tools
  ragenix
  tree
  wget
]
