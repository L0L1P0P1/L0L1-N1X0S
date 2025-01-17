{config, lib, pkgs}:
{
	options = {
		photoPrism.enable =
			lib.mkEnableOption "enables photoPrism";
	};

	config = lib.mkIf config.photoPrism.enable {
		services.photoprism = {
			enable = true;
			originalsPath = "/home/L0L1P0P/Photos";
		};
	};
}
