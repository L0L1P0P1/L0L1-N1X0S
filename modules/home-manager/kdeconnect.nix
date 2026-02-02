{
  lib,
  config,
  ...
}:
{
  options.kdeconnect.enable = lib.mkEnableOption "enables kdeconnect";

  config = lib.mkIf config.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
