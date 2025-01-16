{config, lib, pkgs, ...}:
{
	options = {
		libreOffice.enable =
			lib.mkEnableOption "enables libreOffice";
	};

	config = lib.mkIf config.libreOffice.enable {
		environment.systemPackages = with pkgs; [
			libreoffice-qt
		];
	};
}
