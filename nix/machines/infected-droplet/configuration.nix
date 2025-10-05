{ pkgs, config, ... }:
let 
  rowKeys = config.users.users.row.openssh.authorizedKeys.keys;
in
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ../../roles/base
    ../../users/row
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "debian-s-1vcpu-512mb-10gb-sfo2-01";
  networking.domain = "";
  services.openssh.enable = true;
  services.do-agent.enable = true;

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

  users.users.root.openssh.authorizedKeys.keys = rowKeys;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "23.11";
}
