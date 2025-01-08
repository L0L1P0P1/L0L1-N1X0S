{config, lib, pkgs, inputs, ... }:

{

	options = {
		picom.enable =
			lib.mkEnableOption "enables Picom";
	};

	config = lib.mkIf config.picom.enable {
		services.picom = {
			enable = true;
			backend = "xrender";
			opacityRule = [
				"90:class_g = 'kitty'"
				"90:class_g = 'rofi'"
				"90:class_g = 'tauon'"
				"90:class_g = 'thunar'"
			];
		};
	};
}
