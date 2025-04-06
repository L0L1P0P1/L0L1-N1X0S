{
	description = "Nixos Config Flake";

	inputs = {
    	nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-24.11";
		};

		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {

		# Sitka Host, Home PC
    	nixosConfigurations.sitka = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixvim.nixosModules.nixvim
				inputs.home-manager.nixosModules.default
				./hosts/sitka/configuration.nix
			];
    	};

		# Poolad Host, Main Laptop
    	nixosConfigurations.poolad = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixvim.nixosModules.nixvim
				inputs.home-manager.nixosModules.default
				./hosts/poolad/configuration.nix
			];
    	};

		# Merdas Host, Laptop Old
    	nixosConfigurations.merdas = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixvim.nixosModules.nixvim
				inputs.home-manager.nixosModules.default
				./hosts/merdas/configuration.nix
			];
    	};

		# Tigraan Host, Laptop Alt
    	nixosConfigurations.tigraan = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixvim.nixosModules.nixvim
				inputs.home-manager.nixosModules.default
				./hosts/tigraan/configuration.nix
			];
    	};

		homeManagerModules.default = ./modules/home-manager;
	};
}
