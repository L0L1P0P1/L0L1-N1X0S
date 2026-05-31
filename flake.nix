{
  description = "Nixos Config Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-flatpak,
      nix-matlab,
      ...
    }@inputs:
    let
      flake-overlays = [
        nix-matlab.overlay
      ];
    in
    {
      # Sitka Host, Home PC
      nixosConfigurations.sitka = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inputs = inputs;
          hostname = "sitka";
        };
        modules = [
          inputs.nixvim.nixosModules.nixvim
          inputs.home-manager.nixosModules.default
          inputs.nix-flatpak.nixosModules.nix-flatpak
          { nixpkgs.overlays = flake-overlays; }
          ./hosts/sitka/configuration.nix
        ];
      };

      # Poolad Host, Main Laptop
      nixosConfigurations.poolad = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inputs = inputs;
          hostname = "poolad";
        };
        modules = [
          inputs.nixvim.nixosModules.nixvim
          inputs.home-manager.nixosModules.default
          inputs.nix-flatpak.nixosModules.nix-flatpak
          { nixpkgs.overlays = flake-overlays; }
          ./hosts/poolad/configuration.nix
        ];
      };
    };
}
