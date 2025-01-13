{config, lib, pkgs, ...}:
{

	options = {
		virtualbox.enable =
			lib.mkEnableOption "enables virtualbox";
	};

	config = lib.mkIf config.virtualbox.enable {
		environment.systemPackages = [
			pkgs.virtualbox
		];

		virtualisation.virtualbox = {
			host.enable = true;
			guest.enable = true;
			guest.dragAndDrop = true;
		};

		users.extraGroups.vboxusers.members = [ "L0L1P0P" ];
	};
}
