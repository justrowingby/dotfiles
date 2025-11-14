{ pkgs, config, lib, modulesPath, ... }:
let 
  rowKeys = config.users.users.row.openssh.authorizedKeys.keys;
in
{
  imports = [
    "${modulesPath}/virtualisation/linode-image.nix"
    ../../roles/base
    ../../users/row
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = rowKeys;
  networking.firewall.allowedTCPPorts = [ 443 ];
  age.secrets.rowenname-dns-key.file = ../../secrets/rowenname-dns-key.age;
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme-dns@rowenna.me";

    certs."rowenna.me" = {
      domain = "rowenna.me";
      extraDomainNames = [ "*.rowenna.me" ];
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets.rowenname-dns-key.path;
    };
  };

  services.silverbullet.enable = true;
  services.caddy = {
    enable = true;
    virtualHosts = {
      "sb.rowenna.me" = {
        useACMEHost = "rowenna.me";
        extraConfig = ''
          reverse_proxy :3000
        '';
      };
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
