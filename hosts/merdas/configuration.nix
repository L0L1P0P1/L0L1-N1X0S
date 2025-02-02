{ config, lib, pkgs, pkgsUnstable, inputs, ... }:

{
	# nix settings	
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		# substituters = [ 
		# 	"https://aseipp-nix-cache.global.ssl.fastly.net"
		# 	"https://cache.nixos.org"
		# ];
	};

	# adds pkgsUnstable 
	_module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
		inherit (pkgs.stdenv.hostPlatform) system;
		inherit (config.nixpkgs) config;
	};

	# modules to Import
	imports = [ 	
		./hardware-configuration.nix
		../../nixosModules
    ];

	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
	};

	time.timeZone = "Asia/Tehran";

	networking = {
		hostName = "merdas"; 
		networkmanager.enable = true;  
		nameservers = [ "8.8.8.8" "8.8.4.4" ];

		# Configure network proxy if necessary
		# proxy.default = "http://user:password@proxy:port/";
		# proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		# Open ports in the firewall.
		# firewall.allowedTCPPorts = [ ... ];
		# firewall.allowedUDPPorts = [ ... ];
		firewall.enable = false;
	};

	services = {
		xserver = {
			enable = true;
			windowManager.qtile.enable = true;
		};

		pipewire = {
			enable = true;
			pulse.enable = true;
		};

		syncthing = {
			enable = true;
			user = "L0L1P0P";
			openDefaultPorts = true;
			dataDir = "/home/L0L1P0P/Documents"; 
			configDir= "/home/L0L1P0P/.config/syncthing";
		};

		# Configure keymap in X11
		# xserver.xkb.layout = "us";
		# xserver.xkb.options = "eurosign:e,caps:escape";

		# Enable CUPS to print documents.
		# printing.enable = true;

		# Enable touchpad support (enabled default in most desktopManager).
		# libinput.enable = true;
	};


	# Select internationalisation properties.
	# i18n.defaultLocale = "en_US.UTF-8";
	# console = {
	#   font = "Lat2-Terminus16";
	#   keyMap = "us";
	#   useXkbConfig = true; # use xkb.options in tty.
	# };

	# Modules to Enable
	desktopApps.enable = true;
	droidcamOBS.enable = false;
	tauon.enable = true;
	nixvim.enable = true;
	zsh.enable = true;
	devTools.enable = true;
	tmux.enable = true;

	users.users.L0L1P0P = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		shell = pkgs.zsh;
		# packages = with pkgs; [];
	};


	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		tree
	];

	security.polkit.enable = true;

	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [ 
			nerdfonts
			noto-fonts-emoji
			ipafont
			iso-flags
			liberation_ttf
			ibm-plex
			sahel-fonts
			vazir-fonts
		];
		fontconfig = {
			defaultFonts = {
				serif = [  "Liberation Serif" "Sahel" ];
				sansSerif = [  "Sahel" ];
				monospace = [ "IBM Plex Mono" ];
			};
		};
	};

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"nvidia-x11"
		"nvidia-settings"
		"obsidian"
		"teamspeak3"
		"rar"
	];

	# Do Not Touch or NixGODs will condemn you to eternal suffering
	system.stateVersion = "24.05";

}

