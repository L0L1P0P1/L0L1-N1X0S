{config, lib, pkgs, ... }:
{

	options = {
		heroic.enable =
			lib.mkEnableOption "enables heroic";
	};

	config = lib.mkIf config.picom.enable {
		environment.systemPackages = [
			pkgs.heroic
		];
	};
}
