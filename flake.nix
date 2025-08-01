{
  description = "My NixOS configuration";

  nixConfig = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, flake-utils, nixos-hardware, impermanence, ... } @ inputs :
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.hello;
      }
    ) // {
      nixosConfigurations.mynixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.impermanence.nixosModules.impermanence
          ./mynixos/configuration.nix
          ./mynixos/hardware-configuration.nix
        ];
      };
    };
}
