{ config, pkgs, lib, ... }:
let 
  commonPkgs = import ./common_packages.nix;
in
{
  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    flake-registry = "";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; ((commonPkgs pkgs) ++ [
    zsh
  ]);

  environment.variables = with pkgs; {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
