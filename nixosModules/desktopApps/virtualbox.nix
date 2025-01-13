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
	};
}
