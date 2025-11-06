{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.cursor-theme = {
    enable = lib.mkEnableOption "enables cursor themes";
    size = lib.mkOption {
      description = "cursor size";
      type = lib.types.int;
      default = 16;
    };
  };

  config = lib.mkIf config.cursor-theme.enable {
    home.pointerCursor = {
      enable = true;
      dotIcons.enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor-Light";
      size = config.cursor-theme.size;
    };
  };
}
