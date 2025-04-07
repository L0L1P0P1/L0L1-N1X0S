{ inputs, config, pkgs, pkgsUnstable, ... }:
{
	imports = [
		./zsh.nix
		./tmux.nix
	];

	_module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
		inherit (pkgs.stdenv.hostPlatform) system;
	};
}
