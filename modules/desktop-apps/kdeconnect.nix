{
  lib,
  config,
  ...
}:

{
  options = {
    kdeconnect.enable = lib.mkEnableOption "enables KDEconnect";
  };

  config = lib.mkIf config.kdeconnect.enable {
    programs.kdeconnect.enable = true;
  };
}
