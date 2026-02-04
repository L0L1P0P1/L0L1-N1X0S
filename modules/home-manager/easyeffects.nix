{
  lib,
  config,
  ...
}:
{
  options.easyeffects.enable = lib.mkEnableOption "enables easyeffects";

  config = lib.mkIf config.easyeffects.enable {
    services.easyeffects = {
      enable = true;
    };
  };
}
