{
    inputs.nixpkgs = {
        url = "github:nixos/nixpkgs/nixos-unstable";
    };
    outputs = { self, nixpkgs }: {
        nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./machines/vm/configuration.nix ({...}: {
                nix.registry.nixpkgs.to = {
                    type = "path";
                    path = nixpkgs;
                };
            }) ];
        };
    };
}
