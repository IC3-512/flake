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

  outputs = { self, nixpkgs, flake-utils, impermanence, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations = {
          main = pkgs.lib.nixosSystem {
            system = system;
            modules = [
              impermanence.nixosModules.impermanence
              ./hosts/main/configuration.nix
              ./hosts/main/hardware-configuration.nix
            ];
          };
          work = pkgs.lib.nixosSystem {
            system = system;
            modules = [
              impermanence.nixosModules.impermanence
              ./hosts/work/configuration.nix
              ./hosts/work/hardware-configuration.nix
            ];
          };          
          laptop = pkgs.lib.nixosSystem {
            system = system;
            modules = [
              impermanence.nixosModules.impermanence
              ./hosts/laptop/configuration.nix
              ./hosts/laptop/hardware-configuration.nix
            ];
          };
          server = pkgs.lib.nixosSystem {
            system = system;
            modules = [
              impermanence.nixosModules.impermanence
              ./hosts/server/configuration.nix
              ./hosts/server/hardware-configuration.nix
            ];
        };
      }
    );
}
