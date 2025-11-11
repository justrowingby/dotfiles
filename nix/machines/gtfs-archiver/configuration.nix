{ pkgs, config, modulesPath, ... }:
let 
  rowKeys = config.users.users.row.openssh.authorizedKeys.keys;
in
{
  imports = [
    "${modulesPath}/virtualisation/google-compute-image.nix"
    ../../roles/base
    ../../users/row
  ];
  
  environment.systemPackages = (with pkgs; [
    protobuf
  ]);

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "gtfs-archiver";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = rowKeys;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
