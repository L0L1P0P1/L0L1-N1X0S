{
  lib,
  config,
  pkgsUnstable,
  ...
}:
{

  options = {
    ghostty = {
      enable = lib.mkEnableOption "enables ghostty";
      fontSize = lib.mkOption {
        description = "Default Terminal Font Size";
        type = lib.types.int;
        default = 11;
      };
    };
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = pkgsUnstable.ghostty;

      systemd.enable = true;
      settings = {
        theme = "Gruvbox Material Dark";
        font-family = "Lilex Nerd Font Medium";
        font-size = config.ghostty.fontSize;
        font-thicken = true;
        confirm-close-surface = false;
        window-padding-balance = true;
        window-decoration = false;
        gtk-single-instance = true;
        bell-features = false;
        cursor-style = "block";
      };
    };
  };

}
