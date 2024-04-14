pkgs:
with pkgs; [
  eza # you'll immediately want a nice ls on a new machine
  file
  git # you'll immediately need git on a new machine
  htop
  neovim # you'll immediately need an editor on a new machine
  nil # you'll immediately want a nix LSP on a new machine
  nixpkgs-fmt # you'll immediately want a nix formatter on a new machine
  nodePackages.bash-language-server # you'll immediately want a bash LSP on a new machine
  tree
  wget
]
