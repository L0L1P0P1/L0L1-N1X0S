{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    heroic.enable = lib.mkEnableOption "enables heroic";
  };

  config = lib.mkIf config.heroic.enable {
    environment.systemPackages = [
      pkgs.heroic
      pkgs.mangohud
      pkgs.protonup-qt
      pkgs.protonup-ng
    ];

    programs.gamemode.enable = true;
  };
}
