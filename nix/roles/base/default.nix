{ config, pkgs, inputs, ... }:
let
  commonPkgs = import ./common_packages.nix;
in
{
  imports = [
    inputs.lix-module.nixosModules.default
    "${inputs.agenix}/modules/age.nix"
    ({ ... }: {
      nix.registry.nixpkgs.to = {
        type = "path";
        path = inputs.nixpkgs-stable;
      };
    })
  ];

  # this adds `pkgs-unstable` as a nixos module specialArg
  _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  # this adds `pkgs-mainline` as a nixos module specialArg
  _module.args.pkgs-mainline = import inputs.nixpkgs-mainline {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
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

  services.openssh = {
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
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
