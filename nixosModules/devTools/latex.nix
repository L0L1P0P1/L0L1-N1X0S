{config, lib, pkgs, ... }:
{

	option = {
		latex.enable = lib.mkEnableOption "enables LaTeX";
	};

	config = lib.mkIf config.latex.enable {
		environment.systemPackages = with pkgs; [
			(texliveMedium.withPackages (ps: with ps; [ 
				standalone 
				preview 
				mathalpha 
			]))
		];
	};
}
