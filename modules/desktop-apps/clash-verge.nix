{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    clash-verge.enable = lib.mkEnableOption "enables clash";
  };

  config = lib.mkIf config.clash-verge.enable {
    programs.clash-verge = {
      package = pkgs.clash-verge-rev;
      enable = true;
    };
    programs.nekoray = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
