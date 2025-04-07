{lib, config, options, pkgsUnstable, ... }:
{


	options = {
		qtile = {
			enable = lib.mkEnableOption "enables qtile";
			border_width = {
				description = "Window Border Widths";
				type = lib.types.int;
				default = 5;
			};
			margin = {
				description = "Window Margins";
				type = lib.types.int;
				default = 10;
			};
		};
	};

	config = lib.If config.qtile.enable {
		xdg.configFile = {
				
		};
	};
}
