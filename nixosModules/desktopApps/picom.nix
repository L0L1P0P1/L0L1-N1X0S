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
			activeOpacity = 0.9;
		};
	};
}
