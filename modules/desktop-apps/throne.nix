{
  config,
  lib,
  pkgsUnstable,
  ...
}:
{
  options = {
    throne.enable = lib.mkEnableOption "enable throne";
  };

  config = lib.mkIf config.throne.enable {
    programs.throne = {
      enable = true;
      package = pkgsUnstable.throne;
      tunMode.enable = true;
      tunMode.setuid = false;
    };
  };
}
