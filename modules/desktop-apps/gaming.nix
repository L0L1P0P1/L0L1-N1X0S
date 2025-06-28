{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    gaming = {
      enable = lib.mkEnableOption "enables gaming module";
      steam.enable = lib.mkEnableOption "enables steam for gaming";
      heroic.enable = lib.mkEnableOption "enables heroic games launcher for gaming";
    };
  };
  
  config = lib.mkIf config.gaming.enable { 

    programs.steam = lib.mkIf config.gaming.steam.enable {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = [
      pkgs.heroic
      pkgs.mangohud
      pkgs.protonup-qt
      pkgs.protonup-ng
    ] 
    ++ lib.optional config.gaming.heroic.enable pkgs.heroic;

    programs.gamemode.enable = true;

  };
}
