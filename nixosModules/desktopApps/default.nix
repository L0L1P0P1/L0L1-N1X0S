{config, lib, pkgs, pkgsUnstable, inputs, ... } :

{

	imports = [
		./droidcamOBS.nix
	];

	options = {
		desktopApps.enable = 
			lib.mkEnableOption "enables desktopApps";
	};
	
	config = lib.mkIf config.desktopApps.enable {

		environment.systemPackages = 
			(with pkgs; [
				# From Stable Channel
				brave
				syncthing
				vlc
				sioyek
				teamspeak_client
				xfce.thunar
				puddletag
				maim

				polybarFull
				picom
				rofi
				rofi-power-menu
				networkmanager_dmenu
				papirus-icon-theme

				nekoray
				pwvucontrol
				nitrogen
				qpwgraph
				xclip
			]) ++ 
			(with pkgsUnstable; [
				# From Unstable Channel
				persepolis
				telegram-desktop
				kitty
				vesktop
				obsidian
				tauon
				v2rayn
				openrgb-with-all-plugins
			]);
	};

}
