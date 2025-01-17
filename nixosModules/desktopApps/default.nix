{config, lib, pkgs, pkgsUnstable, inputs, ... } :

{

	imports = [
		./droidcamOBS.nix
		./picom.nix
		./tauon.nix
		./virtualbox.nix
		./heroic.nix
		./libreOffice.nix
		./photoPrism.nix
		./immich.nix
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
				v2rayn
				openrgb-with-all-plugins
			]);
	};

}
