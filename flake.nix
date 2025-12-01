{
  description = "Nixos Config Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
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
          { nixpkgs.overlays = flake-overlays; }
          ./hosts/poolad/configuration.nix
        ];
      };
    };
}
