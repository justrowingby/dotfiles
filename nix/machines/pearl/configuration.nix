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
      ../../roles/fcitx-wayland
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
    jade = {
      isNormalUser = true;
      description = "jades";
      extraGroups = ["networkmanager" "wheel"];
      openssh.authorizedKeys.keys = [
	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNldAg4t13/i69TD786The+U3wbiNUdW2Kc9KNWvEhgpf4y4x4Sft0oYfkPw5cjX4H3APqfD+b7ItAG0GCbwHw6KMYPoVMNK08zBMJUqt1XExbqGeFLqBaeqDsmEAYXJRbjMTAorpOCtgQdoCKK/DvZ51zUWXxT8UBNHSl19Ryv5Ry5VVdbAE35rqs57DQ9+ma6htXnsBEmmnC+1Zv1FE956m/OpBTId50mor7nS2FguAtPZnDPpTd5zl9kZmJEuWCrmy6iinw5V4Uy1mLeZkQv+/FtozbyifCRCvps9nHpv4mBSU5ABLgnRRvXs+D41Jx7xloNADr1nNgpsNrYaTh hed-bot-ssh-tpm-rsa"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKYljH8iPMrH00lOb3ETxRrZimdKzPPEdsJQ5D5ovtOwAAAACnNzaDpzc2hrZXk= ssh:sshkey"
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBO4idMfdJxDJuBNOid60d4I+qxj09RHt+YkCYV2eXt6tGrEXg+S8hTQusy/SqooiXUH9pt4tea2RuBPN9+UwrH0= type-a yubikey slot 9a"
      ];
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
