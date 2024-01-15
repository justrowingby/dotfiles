{
  inputs = {
    flakey-profile.url = "github:lf-/flakey-profile";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flakey-profile, flake-utils }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/vm/configuration.nix
        ({ ... }: {
          nix.registry.nixpkgs.to = {
            type = "path";
            path = nixpkgs;
          };
        })
      ];
    };
  } // (flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      commonBasePkgs = import ./roles/base/common_packages.nix;
      commonDevPkgs = import ./roles/dev/common_packages.nix;
    in
    {
      # Any extra arguments to mkProfile are forwarded directly to pkgs.buildEnv.
      #
      # Usage:
      # Switch to this flake:
      #   nix run .#profile.switch
      # Revert a profile change (note: does not revert pins):
      #   nix run .#profile.rollback
      # Build, without switching:
      #   nix build .#profile
      # Pin nixpkgs in the flake registry and in NIX_PATH, so that
      # `nix run nixpkgs#hello` and `nix-shell -p hello --run hello` will
      # resolve to the same hello as below:
      #   nix run .#profile.pin
      packages.profile = flakey-profile.lib.mkProfile {
        inherit pkgs;
        # Specifies things to pin in the flake registry and in NIX_PATH.
        pinned = { nixpkgs = toString nixpkgs; };
        paths = (commonBasePkgs pkgs) ++ (commonDevPkgs pkgs);
      };
    }
  ));
}
