{ pkgs, config, ... }:
let 
  rowKeys = [ 
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWoOfRnmnpE0IVHyH+CGcOxeKkqssZkVqT2JIZqfgSo9AZcMCyIveXY/PLQfJY2fEMx292CZKouZHA8wtKM/QQLOJOjCupuD3WgO+Zex75QxIjEJtMczXFvQKsgNt6UUmLDYwc04X8Hk8zwO7HAZgQ+tvpWxkfQ/C1/wSMRvvxbTCLisRLWIkuDlGIi2lVGwFB6aMyhw0uuuLcg+aJR7SK/5SzB/+t/vt6sb/SZtxUW1hi/VmF4RNsfhhbfmv6XfTubsc/tgtIZ5g8M2P4N1s2lWgHSlsFoxgzW4IP+sKqXdD0kGAYJSvgCHIjAgxpVy4Ax8DfSuzqqTaT/76ADq+nI3xqAF9utpHi9M23zvbp0l0OS8ELrMuz++hq0BNggjK3gunlCRv2IvzdAiHKRAf9IUdOcaBS92JZTYlttFtK5uNrOE/79DPvLaCmUjtzxhJKC8i224lFy5wqqjwYGXKJsRi7P/xJJ0RY8NlB1QsVgEgwp7tcRvXcPAggY1eogAk= row@arrow.local''
    ''sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIA9xY2LFFO2ZPsyn71YXDP+N8MKmR2E1DO6RURmmAWlDAAAABHNzaDo= ssh:''
  ];
in
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ../../roles/base
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
  users.users = {
    row = {
      isNormalUser = true;
      description = "Rowenna Emma";
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = rowKeys; 
    };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "23.11";
}
