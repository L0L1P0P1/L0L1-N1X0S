{config, lib, pkgs, inputs, ... } :

{
	imports = [
		./programs
		./desktop-apps
		./home-manager
	];
}
