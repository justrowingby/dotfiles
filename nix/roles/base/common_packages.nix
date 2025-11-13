pkgs:
with pkgs; [
  coreutils-prefixed
  fd
  file
  fish
  git # you'll immediately need git on a new machine
  htop
  neovim # you'll immediately need an editor on a new machine
  openssh # ensure macOS profiles can use non-busted ssh tools
  tree
  wget
]
