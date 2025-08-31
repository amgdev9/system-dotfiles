{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      amg-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ./nix/hosts/amg-laptop.nix ];
      };

      amg-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ./nix/hosts/amg-pc.nix ];
      };
    };
  };
}
