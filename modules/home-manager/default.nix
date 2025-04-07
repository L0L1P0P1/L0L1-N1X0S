{ inputs, config, pkgs, pkgsUnstable, ... }:
{
	imports = [
		./zsh.nix
		./tmux.nix
		./kitty.nix
	];

	_module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
		inherit (pkgs.stdenv.hostPlatform) system;
	};

	xdg.enable = true;
}
