{ config, pkgs, lib, ... }: {
  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    flake-registry = "";
  };

  environment.systemPackages = with pkgs; [
    neovim
    file
    tree
    htop
    zsh
  ];
}
