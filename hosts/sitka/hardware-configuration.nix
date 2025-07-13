{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "vmd"
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
    "i2c-dev"
  ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/badba080-d4d5-448b-bef3-6779bc2d91a8";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6774-5EA2";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NIXHOME";
    fsType = "ext4";
  };

  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/6422C87222C84AAE";
    fsType = "ntfs-3g";
    options = [ "rw" ];
  };

  fileSystems."/mnt/e" = {
    device = "/dev/disk/by-uuid/0E0CCFF60CCFD73D";
    fsType = "ntfs-3g";
    options = [ "rw" ];
  };

  fileSystems."/var/lib/immich" = {
    device = "/mnt/e/Photos";
    options = [ "bind" ];
  };

  # OpenRGB
  services.udev.packages = [ pkgs.openrgb-with-all-plugins ];
  hardware.i2c.enable = true;
  users.groups.i2c.members = [ "L0L1P0P" ];
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable graphics
  hardware.graphics = {
    enable = true;
  };

  # Monitor setup
  services.xserver.displayManager.setupCommands = ''
    		KWIN_OPENGL_INTERFACE=egl
    		__GL_SYNC_DISPLAY_DEVICE=DP-0
    		${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --primary --pos 0x0 --mode 2560x1440 --rate 170 --output HDMI-0 --mode 1920x1080 --rate 60 --pos 2560x0
    	'';

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
  };
}
