{lib, config, pkgsUnstable, ... }:
{

	options = {
		kitty.enable = lib.mkEnableOption "enables kitty";
	};

	config = lib.mkIf config.kitty.enable {
		programs.kitty = {
			enable = true;
			
			themeFile = "GruvboxMaterialDarkSoft";	
			font.name = "IBM Plex Mono";
			font.size = "16";

			settings = {
				 confirm_os_window_close = 0;
			};
		};
	};
}
