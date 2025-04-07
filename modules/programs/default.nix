{config, lib, pkgs, pkgsUnstable, inputs, ... } :
{
	imports = [
		./arduino.nix
		./cli-tools.nix
		./environments.nix
		./latex.nix
		# ./zsh.nix

		./nixvim
		# ./tmux
	];
}
