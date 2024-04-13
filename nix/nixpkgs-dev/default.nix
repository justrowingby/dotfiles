{
  nixpkgs-dev ? builtins.fetchTarball {
    # https://github.com/nixos/nixpkgs/tree/master
    url = "https://github.com/nixos/nixpkgs/archive/cfd6b5fc90b15709b780a5a1619695a88505a176.tar.gz";
    sha256 = "sha256:08yjq1miiy24j5jr4skma0ah4brjiswg6wzlas4dg582z05bvaaq";
    name = "source";
  }
}:
let
  sources = {
    # If you want to update these manually, update the commit ID then set sha256
    # to an empty string (or lib.fakeHash directly) and then update the hash to 
    # whatever the error gives you.
    #
    flakey-profile = builtins.fetchTarball {
      # https://github.com/lf-/flakey-profile/tree/main
      url = "https://github.com/lf-/flakey-profile/archive/243c903fd8eadc0f63d205665a92d4df91d42d9d.tar.gz";
      sha256 = "sha256:1wpz9aqxyhamjzbddsqsm1j8ya2d77fwf5x1hh170m3p9w8qh48n";
      name = "source";
    };
    inherit nixpkgs-dev;
  };

  # simplest way of getting nixpkgs: use nix-channel to manage versions
  /*
  pkgs = import <nixpkgs> { };
  */

  # mildly less convenient, but pinned:
  pkgs = import sources.nixpkgs-dev { };

  flakey-profile = import (sources.flakey-profile + "/lib");

  commonBasePkgs = import ../roles/base/common_packages.nix;
  commonDevPkgs = import ../roles/dev/common_packages.nix;

in
{
  profile = flakey-profile.mkProfile {
    # Usage:
    # Switch to this profile:
    #   nix run -f . profile.switch
    # Revert a profile change:
    #   nix run -f . profile.rollback
    # Build, without switching:
    #   nix build -f . profile
    inherit pkgs;
    pinned = { inherit (sources) nixpkgs-dev; };
    paths = (commonBasePkgs pkgs) ++ (commonDevPkgs pkgs) ++
    (with pkgs; [ hello ]); # list remaining packages by name 
  };
}
