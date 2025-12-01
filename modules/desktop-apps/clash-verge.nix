{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  options = {
    clash-verge.enable = lib.mkEnableOption "enables clash";
  };

  config = lib.mkIf config.clash-verge.enable {
    programs.clash-verge = {
      package = pkgs.clash-verge-rev;
      serviceMode = true;
      autoStart = true;
      tunMode = true;
      enable = true;
    };
  };
}
