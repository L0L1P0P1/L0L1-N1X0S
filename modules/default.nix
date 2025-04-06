{config, lib, pkgs, inputs, ... } :

{
	imports = [
		./nixvim
		./zsh.nix
		./tmux

		./programs
		./desktop-apps
	];
}
