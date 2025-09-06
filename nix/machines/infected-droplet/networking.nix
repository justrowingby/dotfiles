{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "67.207.67.2"
 "67.207.67.3"
 "67.207.67.2"
 "67.207.67.3"
 "67.207.67.2"
 "67.207.67.3"
 ];
    defaultGateway = "142.93.16.1";
    defaultGateway6 = {
      address = "2604:a880:2:d1::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="142.93.17.67"; prefixLength=20; }
{ address="10.46.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="2604:a880:2:d1::c9ca:7001"; prefixLength=64; }
{ address="fe80::cc9e:faff:fe33:944b"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "142.93.16.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "2604:a880:2:d1::1"; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.120.0.2"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::6449:b5ff:fea2:4cd5"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="ce:9e:fa:33:94:4b", NAME="eth0"
    ATTR{address}=="66:49:b5:a2:4c:d5", NAME="eth1"
  '';
}
