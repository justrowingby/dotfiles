{
  inputs = {
    flakey-profile.url = "github:lf-/flakey-profile";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-mainline.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    lix-src = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.flakey-profile.follows = "flakey-profile";
      inputs.flake-utils.follows = "flake-utils";
      inputs.lix.follows = "lix-src";
    };
  };
  outputs = { self, nixpkgs-stable, nixpkgs-unstable, nixpkgs-mainline, lix-src, lix-module, flakey-profile, flake-utils }: {
    nixosConfigurations.vm = nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      
      modules = [
        lix-module.nixosModules.default
        machines/vm/configuration.nix
        ({ ... }: {
          nix.registry.nixpkgs.to = {
            type = "path";
            path = nixpkgs-stable;
          };
        })
      ];
    };
    nixosConfigurations.pearl = nixpkgs-stable.lib.nixosSystem rec {
      system = "x86_64-linux"; 
      
      modules = [
        lix-module.nixosModules.default
        machines/pearl/configuration.nix
        ({ ... }: {
          nix.registry.nixpkgs.to = {
            type = "path";
            path = nixpkgs-stable;
          };
        })
      ];
    };
   } // (flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      
      # The `specialArgs` parameter passes the
      # non-default nixpkgs instances to other nix modules
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable {
	  inherit system;
	  config-allowUnfree = true;
	};
        pkgs-mainline = import nixpkgs-mainline {
          inherit system;
          config.allowUnfree = true;
        };
      };
      
      commonBasePkgs = import roles/base/common_packages.nix;
      commonDevPkgs = import roles/dev/common_packages.nix;
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
      #   sudo nix run .#profile.pin # [should pawbly be run as root]
      packages.bootstrap-profile = flakey-profile.lib.mkProfile {
        inherit pkgs;
        # Specifies things to pin in the flake registry and in NIX_PATH.
        pinned = { nixpkgs = toString nixpkgs-stable; };
        paths = (commonBasePkgs pkgs);
      };
      packages.dev-profile = flakey-profile.lib.mkProfile {
        inherit pkgs;
        # Specifies things to pin in the flake registry and in NIX_PATH.
        pinned = { nixpkgs = toString nixpkgs-stable; };
        paths = (commonBasePkgs pkgs) ++ (commonDevPkgs pkgs);
      };
      packages.system-lix-profile = lix-module.packages."${system}".system-profile;
    }
  ));
}
