{config, lib, pkgs, ...}:
{
	options = {
		immich.enable =
			lib.mkEnableOption "enables immich";
	};

	config = lib.mkIf config.immich.enable {
		services.immich = {
			enable = true;
			port = 2283;
		};
		users.users.immich.extraGroups = [ "video" "render" ];
	};
}
