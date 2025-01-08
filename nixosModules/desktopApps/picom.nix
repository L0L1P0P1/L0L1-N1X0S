{config, lib, pkgsUnstable, inputs, ... }:

{

	options = {
		picom.enable =
			lib.mkEnableOption "enables Picom";
	};

	config = lib.mkIf config.picom.enable {
		services.picom = {
			enable = true;
			package = pkgsUnstable.picom;
			backend = "xrender";
			opacityRules = [
				"94:class_g = 'kitty'"
				"85:class_g = 'Rofi'"
				"90:class_g = 'tauonmb'"
				"90:class_g = 'Thunar'"
				"90:class_g = 'vesktop'"
				"90:class_g = 'TelegramDesktop'"
			];
			settings = {
				blur = {
					method = "gaussian";
					size = 15;
					deviation = 7.5;
				};
				blur-background-exclude = [
				  "window_type = 'menu'"
				  "window_type = 'dropdown_menu'"
				  "window_type = 'popup_menu'"
				  "window_type = 'tooltip'"
				];
				# animations = [
				# {
				# 	   triggers = [ "close"  "hide" ];
				# 	   preset = "slide-out";
				# 	   direction = "down";
				# 	}
				# ];
			};
				
			vSync = true;
		};
	};
}
