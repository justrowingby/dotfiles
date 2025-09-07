let
  # put /etc/ssh/ssh_host_ed25519_key.pub here
  systems = {
    infected-droplet = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKEzP7/x5k/awBV0fTx6dtTj7qv+GUfFJDnuR/DwWCY root@debian-s-1vcpu-1gb-sfo2-01";
  };
  # put keys here which should be able to decrypt without a host key
  backupKeys = {
    edc-yubikey-5c-slim = "age1yubikey1q2ympfmujc80fvfagxu5rjxasm3k4l3sf39zmg2l3s2knd7ew0kc2skxwm7";
    fxd-yubikey-5c-micro = "age1yubikey1qdpnnthqn8afsq0s6pg3hfek0kzsl3r2pgwh36xfa4733ewzrjz3gdlgnrv";
  };
  allBackupKeys = builtins.attrValues backupKeys;
  allSystems = builtins.attrValues systems;
in {
  "rowenname-dns-key.age".publicKeys = allBackupKeys ++ [systems.infected-droplet];
}
