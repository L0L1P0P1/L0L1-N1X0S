{config, lib, pkgs, ... }:
{

	options = {
		latex.enable = lib.mkEnableOption "enables LaTeX";
	};

	config = lib.mkIf config.latex.enable {
		environment.systemPackages = with pkgs; [
			texliveFull
			(texliveMedium.withPackages (ps: with ps; [ 
				standalone 
				preview 
				mathalpha 
			]))
		];
	};
}
