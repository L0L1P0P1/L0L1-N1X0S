{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    cursor-theme.enable = lib.mkEnableOption "enables cursor themes";
  };

  config = lib.mkIf config.cursor-theme.enable {
    home.pointerCursor = {
      enable = true;
      dotIcons.enable = true;
      gtk.enable = true;
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor-Light";
      size = 16;
    };
  };
}
