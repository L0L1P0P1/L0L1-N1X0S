{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  # nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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
    ../../modules
  ];

  boot.loader = {
    systemd-boot.enable = false;
    efi = {
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
    # nameservers = [
    #   "1.1.1.1"
    #   "8.8.8.8"
    # ];

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    firewall.enable = false;
  };

  environment.etc."resolv.conf".enable = false;

  services = {
    xserver = {
      enable = true;
      windowManager.qtile.enable = true;
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "1";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "1";
        disableWhileTyping = true;
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    syncthing = {
      enable = true;
      user = "L0L1P0P";
      openDefaultPorts = true;
      dataDir = "/home/L0L1P0P/Documents";
      configDir = "/home/L0L1P0P/.config/syncthing";
    };

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "L0L1P0P" ]; # Allows all users by default. Can be [ "user1" "user2" ]
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
  i18n.defaultLocale = "en_US.UTF-8";

  # Modules to Enable
  arduino.enable = false;
  audacity.enable = true;
  clash-verge.enable = true;
  cli-tools.enable = true;
  desktopApps.enable = true;
  droidcamOBS.enable = true;
  environments.enable = true;
  gimp.enable = true;
  immich.enable = true;
  latex.enable = true;
  libreOffice.enable = true;
  nekoray.enable = true;
  nix-ld.enable = true;
  nixvim.enable = true;
  pdfTools.enable = true;
  photoPrism.enable = false;
  picom.enable = true;
  tauon.enable = true;
  teamspeak.enable = true;
  virtualbox.enable = true;
  gaming = {
    enable = true;
    steam.enable = true;
    heroic.enable = true;
    prismlauncher.enable = true;
  };

  # User
  users.users.L0L1P0P = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "dialout"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgsUnstable.zsh;
    packages = with pkgs; [ matlab ];
  };

  # shell environment
  environment.shells = [ pkgsUnstable.zsh ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."L0L1P0P" = import ./home.nix;
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
  security.sudo = {
    enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.blex-mono
      nerd-fonts.hack
      nerd-fonts.ubuntu-mono
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      ipafont
      iso-flags
      liberation_ttf
      ibm-plex
      sahel-fonts
      vazir-fonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Liberation Serif"
          "Sahel"
        ];
        sansSerif = [ "Sahel" ];
        monospace = [ "IBM Plex Mono" ];
      };
      useEmbeddedBitmaps = true;
    };
  };

  # Do Not Touch or NixGODs will condemn you to eternal suffering
  system.stateVersion = "24.05";

}
