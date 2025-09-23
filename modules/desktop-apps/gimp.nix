{
  lib,
  config,
  pkgsUnstable,
  ...
}:
{
  options.gimp.enable = lib.mkEnableOption "enable gimp";

  config = lib.mkIf config.gimp.enable {
    environment.systemPackages = with pkgsUnstable; [
      gimp
    ];
  };
}
