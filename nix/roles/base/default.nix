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
  
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
