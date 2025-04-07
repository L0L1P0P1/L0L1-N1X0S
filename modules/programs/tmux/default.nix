{config, lib, pkgs, pkgsUnstable, inputs, ...}:
{
	options = {
		tmuxold.enable =
			lib.mkEnableOption "enables tmux";
	};

	config = lib.mkIf config.tmuxold.enable {

		programs.tmux = {
			enable = true;
			plugins = with pkgs.tmuxPlugins; [
				continuum
				resurrect
				sensible
			];
		};

		environment.systemPackages = (with pkgs; [
			tmux
		]) ++
		(with pkgsUnstable; [
			fzf
		]);

	};

}
