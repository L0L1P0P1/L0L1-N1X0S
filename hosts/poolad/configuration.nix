{ config, lib, pkgs, pkgsUnstable, inputs, ... }:

{
	# nix settings	
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		substituters = [ 
			"https://cache.nixos.org"
#			"http://192.168.1.100:8080"
		];

		# have this enabled only if you are using absolutely trusted caches (mines local)
		require-sigs = false;
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
		../../modules
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
			gfxmodeEfi = "2880x1800";
		};
	};

	time.timeZone = "Asia/Tehran";

	networking = {
		hostName = "poolad"; 
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
			dpi = 150;
			windowManager.qtile.enable = true;
			videoDrivers = [ "amdgpu" ];
		};
		libinput = {
			enable = true;
			mouse = {
				accelProfile = "flat";
				accelSpeed = "1";
			};
			touchpad = {
				accelProfile = "flat";
				accelSpeed = "0.8";
				disableWhileTyping = true;
			};
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
		tumbler.enable = true;
		gvfs.enable = true;
		udev.extraRules = ''
			ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
		'';
	};


	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Modules to Enable
	cli-tools.enable = true;
	desktopApps.enable = true;
	droidcamOBS.enable = false;
	environments.enable = true;
	heroic.enable = true;
	nixvim.enable = true;
	picom.enable = false;
	tauon.enable = true;
	teamspeak.enable = true;
	tmux.enable = true;

	# User
	users.users.L0L1P0P = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		shell = pkgsUnstable.zsh;
		# packages = with pkgs; [];
	};

	# Home Manager
	home-manager = {
		extraSpecialArgs = {inherit inputs;};
		users."L0L1P0P" = import ./home.nix;
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		tree
		lxqt.lxqt-policykit
	];

	# Dconf
	programs.dconf.enable = true;

	# polkit
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

