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
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall.enable = false;

    nameservers = [
      "1.1.1.1"
      "0.0.0.0"
    ];
  };

  services = {
    xserver = {
      enable = true;
      dpi = 100;
      windowManager.qtile.enable = true;
    };

    kubo = {
      enable = true;
      settings.Addresses = {
        Gateway = "/ip4/127.0.0.1/tcp/8085";
        API = [ "/ip4/127.0.0.1/tcp/5001" ];
      };
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
        AllowUsers = [ "L0L1P0P" ];
        UseDns = true;
        PermitRootLogin = "no";
      };
    };

    nix-serve = {
      enable = true;
      port = 8080;
    };

    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    tumbler.enable = true;
    gvfs.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Modules to Enable
  arduino.enable = true;
  audacity.enable = true;
  clash-verge.enable = true;
  cli-tools.enable = true;
  desktopApps.enable = true;
  docker.enable = true;
  droidcamOBS.enable = true;
  environments.enable = true;
  gimp.enable = true;
  immich.enable = true;
  kdenlive.enable = true;
  latex.enable = true;
  libreOffice.enable = true;
  throne.enable = true;
  nix-ld.enable = true;
  pdfTools.enable = true;
  photoPrism.enable = false;
  picom.enable = false;
  sddm.enable = true;
  tauon.enable = true;
  teamspeak.enable = false;
  virtualbox.enable = true;
  flatpak = {
    enable = true;
    stremio.enable = true;
    teamspeak3.enable = true;
  };
  gaming = {
    enable = true;
    steam.enable = true;
    heroic.enable = true;
    prismlauncher.enable = true;
  };
  nixvim = {
    enable = true;
    obsidianWorkspaces = [
      {
        name = "Übermensch";
        path = "/home/L0L1P0P/Documents/Documents-Sync/Obsidian/Übermensch";
      }
      {
        name = "TheWoodenBox";
        path = "/home/L0L1P0P/Documents/Documents-Sync/Obsidian/TheWoodenBox";
      }
    ];
  };

  # User
  users.users.L0L1P0P = {
    isNormalUser = true;
    extraGroups = [
      config.services.kubo.group
      "wheel"
      "dialout"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [ matlab ];
  };

  # shell environment
  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."L0L1P0P" = import ./home.nix;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
  ];

  # Dconf
  programs.dconf.enable = true;

  # Polkit
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
  };
  security.pam.services = {
    i3lock.enable = true;
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
