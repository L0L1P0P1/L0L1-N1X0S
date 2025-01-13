{ config, lib, pkgs, pkgsUnstable, inputs, ... }:

{
	# nix settings	
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		# substituters = [ 
		# 	"https://nix-community.cachix.org"
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
		hostName = "sitka"; 
		networkmanager.enable = true;  
		nameservers = [ "1.1.1.1" "8.8.8.8" ];

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
		printing.enable = true;

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
	droidcamOBS.enable = true;
	nixvim.enable = true;
	picom.enable = true;
	tauon.enable = true;
	zsh.enable = true;
	devTools.enable = true;
	tmux.enable = true;

	# User
	users.users.L0L1P0P = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		shell = pkgs.zsh;
		# packages = with pkgs; [];
	};

	# Home Manager
	home-manager = {
		extraSpecialArgs = {inherit inputs;};
		users = {
			"L0L1P0P" = import ./home.nix;
		};
	};
	
	# System packages
	environment.systemPackages = with pkgs; [
		tree
		polkit_gnome
	];

	# Dconf
	programs.dconf.enable = true;

	# Polkit
	security.polkit.enable = true;
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
		description = "polkit-gnome-authentication-agent-1";
		wantedBy = [ "graphical-session.target" ];
		wants = [ "graphical-session.target" ];
		after = [ "graphical-session.target" ];
		serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
			TimeoutStopSec = 10;
		};
    };

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
		"steam"
	];

	# Do Not Touch or NixGODs will condemn you to eternal suffering
	system.stateVersion = "24.05";

}

