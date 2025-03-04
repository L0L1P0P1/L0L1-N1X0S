{ config, lib, pkgs, pkgsUnstable, inputs, ... }:

{
	# nix settings	
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			# substituters = [ 
			# 	"https://nix-community.cachix.org"
			# 	"https://cache.nixos.org"
			# ];
		};
		
		# sshServe = {
		# 	enable = true;
		# 	keys = [];
		# };
	};

	# adds pkgsUnstable 
	_module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
		inherit (pkgs.stdenv.hostPlatform) system;
		inherit (config.nixpkgs) config;
	};

	nixpkgs.config.allowUnfree = true;

	# modules to Import
	imports = [ 	
		./hardware-configuration.nix
		../../nixosModules
    ];

	boot.loader = {
		systemd-boot.enable = false;
		efi= {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		grub = {
			efiSupport = true;
			enable = true;
			useOSProber = true;
			device = "nodev";
			gfxmodeEfi = "2560x1440";
		};
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

		openssh = {
			enable = true;
			ports = [ 22 ];
			settings = {
				PasswordAuthentication = true;
				AllowUsers = ["L0L1P0P"]; # Allows all users by default. Can be [ "user1" "user2" ]
				UseDns = true;
				PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
			};
		};

		nix-serve = {
			enable = true;
			port = 8080;
		};

		# Configure keymap in X11
		# xserver.xkb.layout = "us";
		# xserver.xkb.options = "eurosign:e,caps:escape";

		# Enable CUPS to print documents.
		printing.enable = true;

		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};

		# Enable touchpad support (enabled default in most desktopManager).
		# libinput.enable = true;

		tumbler.enable = true;
		gvfs.enable = true;
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
	virtualbox.enable = true;
	photoPrism.enable = false;
	immich.enable = true;
	heroic.enable = true;
	nixvim.enable = true;
	picom.enable = true;
	libreOffice.enable = true;
	tauon.enable = true;
	zsh.enable = true;
	devTools.enable = true;
	arduino.enable = false;
	tmux.enable = true;
	teamspeak.enable = true;

	# User
	users.users.L0L1P0P = {
		isNormalUser = true;
		extraGroups = [ "wheel" "dialout" ]; # Enable ‘sudo’ for the user.
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
		lxqt.lxqt-policykit
	];

	# Dconf
	programs.dconf.enable = true;

	# Polkit
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
			useEmbeddedBitmaps = true;
		};
	};

	# Do Not Touch or NixGODs will condemn you to eternal suffering
	system.stateVersion = "24.05";

}

