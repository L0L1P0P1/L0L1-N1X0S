{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.platformio.enable = lib.mkEnableOption "enable platformio";

  config = lib.mkIf config.platformio.enable {
    environment.systemPackages = [
      pkgs.platformio-core
    ];
    services.udev.packages = [
      pkgs.platformio-core.udev
      pkgs.openocd
    ];
  };
}
