{config, lib, pkgsUnstable, ... }:
{
  options = {
    clash-verge.enable = lib.mkEnableOption "enables clash"; 
  };

  config = lib.mkIf config.clash-verge.enable {
    programs.clash-verge = {
      enable = true;
      tunMode = true;
      autoStart = true;
    };
  };
}
