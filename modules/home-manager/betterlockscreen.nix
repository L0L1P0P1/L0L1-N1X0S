{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.betterlockscreen = {
    enable = lib.mkEnableOption "enables betterlockscreen";
    arguments = lib.mkOption {
      description = "argumets for betterlockscreen";
      type = lib.types.listOf lib.types.str;
      default = [ "--show-layout" ];
    };
  };

  config = lib.mkIf config.betterlockscreen.enable {
    services.betterlockscreen = {
      enable = true;
      arguments = config.betterlockscreen.arguments;
    };
  };
}
