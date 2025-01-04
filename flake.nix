{
	description = "Nixos Config Flake";

	inputs = {
    	nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-24.11";
		};

		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixpkgs-unstable";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		home-manager = {
		  url = "github:nix-community/home-manager";
		  inputs.nixpkgs.follows = "nixpkgs";
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

		# Merdas Host, Laptop
    	nixosConfigurations.merdas = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixvim.nixosModules.nixvim
				./hosts/merdas/configuration.nix
			];
    	};

	};
}
