{config, lib, pkgs, ...}:
{

	options = {
		virtualbox.enable =
			lib.mkEnableOption "enables virtualbox";
	};

	config = lib.mkIf config.virtualbox.enable {

		virtualisation.virtualbox = {
			host.enable = true;
		};
		users.extraGroups.vboxusers.members = [ "L0L1P0P" ];
	};
}
