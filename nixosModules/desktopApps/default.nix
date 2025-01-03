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
				kitty
				vlc
				sioyek
				teamspeak_client
				xfce.thunar
				puddletag
				maim
				rofi
				nekoray
				pwvucontrol
				nitrogen
				qpwgraph
				xclip
				polybar
			]) ++ 
			(with pkgsUnstable; [
				# From Unstable Channel
				persepolis
				telegram-desktop
				vesktop
				obsidian
				tauon
				v2rayn
				openrgb-with-all-plugins
			]);
	};

}
