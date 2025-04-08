{pkgs, config, lib, ...}:
{

	options = {
		audacity.enable = lib.mkEnableOption "Enables audacity";
	};

	config = lib.mkIf config.audacity.enable {
		environment.systemPackages = with pkgs; [
			audacity
		];
	};
}
