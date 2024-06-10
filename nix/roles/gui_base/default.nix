{ config, pkgs, lib, pkgs-latest, ... }:
{
  environment.systemPackages = ((with pkgs; [
    v4l-utils

    firefox
    kate

    vesktop
    telegram-desktop
    signal-desktop
    # thunderbird

    kdePackages.bluedevil
  ]) ++
  (with pkgs-latest; [
    #signal-desktop
  ]));

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
	user = "row";
      };
      sddm = {
        enable = true;
        autoNumlock = true;
        wayland = {
          enable = true;
	  compositor = "kwin";
	};
      };
    };
    desktopManager.plasma5.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "row";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
}
