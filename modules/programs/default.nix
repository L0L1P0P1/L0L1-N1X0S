{config, lib, pkgs, pkgsUnstable, inputs, ... } :
{
	imports = [
		./arduino.nix
		./latex.nix
		./zsh.nix
		./environments.nix
		./cli-tools.nix

		./nixvim
		./tmux
	];
}
