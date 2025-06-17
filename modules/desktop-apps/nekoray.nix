{
  config,
  lib,
  pkgsUnstable,
  ...
}:
{
  options = {
    nekoray.enable = lib.mkEnableOption "enable nekoray";
  };

  config = lib.mkIf config.nekoray.enable {
    programs.nekoray = {
      enable = true;
      package = pkgsUnstable.nekoray;
      tunMode.enable = true;
    };
  };
}
