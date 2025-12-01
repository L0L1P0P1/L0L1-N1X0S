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
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      #	"http://192.168.1.100:8080"
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

  boot = {
    plymouth = {
      enable = true;
    };
    loader = {
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
        gfxmodeEfi = "2880x1800";
      };
    };
  };

  time.timeZone = "Asia/Tehran";

  networking = {
    hostName = "poolad";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  environment.etc."resolv.conf".enable = false;

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
      configDir = "/home/L0L1P0P/.config/syncthing";
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 75;
      };
    };

    tumbler.enable = true;
    gvfs.enable = true;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Modules to Enable
  audacity.enable = true;
  clash-verge.enable = true;
  cli-tools.enable = true;
  desktopApps.enable = true;
  environments.enable = true;
  libreOffice.enable = true;
  throne.enable = true;
  sddm.enable = true;
  picom.enable = true;
  tauon.enable = true;
  teamspeak.enable = true;
  virtualbox.enable = true;
  gaming = {
    enable = true;
    heroic.enable = true;
  };
  nixvim = {
    enable = true;
    obsidianWorkspaces = [
      {
        name = "Übermensch";
        path = "/home/L0L1P0P/Documents-Sync/Obsidian/Übermensch";
      }
      {
        name = "TheWoodenBox";
        path = "/home/L0L1P0P/Documents-Sync/Obsidian/TheWoodenBox";
      }
    ];
  };

  # User
  users.users.L0L1P0P = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = with pkgs; [ matlab ];
  };

  # shell environment
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."L0L1P0P" = import ./home.nix;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
  ];

  # Dconf
  programs.dconf.enable = true;

  # polkit
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
