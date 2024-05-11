{ config, pkgs, lib, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.200.254.16/32" ];
      dns = [ "10.200.254.1" ];
      privateKeyFile = "/home/row/.secrets/wg_prv";
      
      peers = [
        {
          publicKey = "DoNiaT4ImOWmshzE0qBbCHuMKWrOQVBMG0jNOs+CmCg=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "atlas-net.devhack.net:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
