# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../roles/base
      ../../roles/dev
      ../../roles/gui_base
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pearl-nixos"; # Define your hostname.

  boot.kernelParams = ["gpu_sched.sched_policy=0"];
  
  services.flatpak.enable = true;
  services.tailscale.enable = true;
  services.hardware.openrgb.enable = true;

  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  nix.package = pkgs.lix;

  environment.systemPackages = ((with pkgs; [
    epiphany
    openrgb-with-all-plugins
  ]) ++
  (with pkgs-unstable; [
    #signal-desktop
  ]));


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    row = {
      isNormalUser = true;
      description = "Rowenna Emma";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    mirmo = {
      isNormalUser = true;
      description = "mirmo";
      extraGroups = ["networkmanager"];
    };
    hecate = {
      isNormalUser = true;
      description = "hecate cantus";
      extraGroups = [ "networkmanager" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
