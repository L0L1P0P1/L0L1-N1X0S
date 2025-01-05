{config, lib, pkgs, pkgsUnstable, inputs, ...}:
{
	options = {
		tmux.enable =
			lib.mkEnableOption "enables tmux";
	};

	config = lib.mkIf config.tmux.enable {

		programs.tmux = {
			enable = true;
			plugins = with pkgs.tmuxPlugins; [
				continuum
				resurrect
				sensible
			];
		};

		environment.systemPackages = with pkgs; [
			tmux
			tmux-sessionizer
		];

	};

}
