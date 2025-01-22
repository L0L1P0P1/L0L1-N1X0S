{config, lib, pkgs, pkgsUnstable, inputs, ...}:
{
	options = {
		zsh.enable =
			lib.mkEnableOption "enables zsh";
	};

	config = lib.mkIf config.zsh.enable {

		programs.zsh = {
			enable=true;
			syntaxHighlighting.enable=true;
		};
		
		environment.systemPackages = with pkgs; [
			zoxide
			zsh-syntax-highlighting
			zsh-autosuggestions
		];
	};

}
