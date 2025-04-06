{config, lib, pkgsUnstable, ... }:
{

	options = {
		tauon.enable =
			lib.mkEnableOption "enables Tauon";
	};

	config = lib.mkIf config.tauon.enable {
		environment.systemPackages = [
			pkgsUnstable.tauon
		];

		services.playerctld.enable = true;
	};
}
