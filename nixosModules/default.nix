{config, lib, pkgs, inputs, ... } :

{
	imports = [
		./nixvim
		./zsh.nix
		./tmux

		./devTools
		./desktopApps
	];
}
