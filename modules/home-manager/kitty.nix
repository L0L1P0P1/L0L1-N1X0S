{lib, config, pkgsUnstable, ... }:
{

	options = {
		kitty = {
			enable = lib.mkEnableOption "enables kitty";
			fontSize = lib.mkOption {
				description = "Default Terminal Font Size";
				type = lib.types.int;
				default = 11;
			};
		};
	};

	config = lib.mkIf config.kitty.enable {
		programs.kitty = {
			enable = true;
			
			themeFile = "GruvboxMaterialDarkMedium";	
			font.name = "IBM Plex Mono";
			font.size = config.kitty.fontSize;

			settings = {
				 confirm_os_window_close = 0;
			};
		};
	};
}
