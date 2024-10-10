{ config, pkgs, lib, pkgs-latest, ... }:
{
  environment.systemPackages = ((with pkgs; [
    v4l-utils

    firefox
    kate

    vlc

    vesktop
    telegram-desktop
    signal-desktop

    (pkgs.wrapOBS {
       plugins = with pkgs.obs-studio-plugins; [
         waveform
	 input-overlay
	 obs-pipewire-audio-capture
       ];
    })

    audacity

    kitty
    kittysay
    kitty-img

    # thunderbird

    kdePackages.bluedevil
    kdePackages.kwallet-pam

    libva-utils
  ]) ++
  (with pkgs-latest; [
    #signal-desktop
  ]));

  programs.dconf.enable = true;

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.displayManager = {
    autoLogin = {
      enable = false;
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
  #services.xserver.desktopManager.plasma5.enable = true;
  services.desktopManager.plasma6.enable = true;

  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "row";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
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
