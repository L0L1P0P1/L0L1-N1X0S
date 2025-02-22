{config, lib, pkgs, ... }:
{

	options = {
		arduino.enable = 
			lib.mkEnableOption "enables arduino";
	};

	config = lib.mkIf config.arduino.enable {
		environment.systemPackages = with pkgs; [
			arduino
			arduino-cli
		];
	};
}
