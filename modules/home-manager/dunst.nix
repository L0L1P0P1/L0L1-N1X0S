{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    dunst.enable = lib.mkEnableOption "enables dunst";
  };

  config = lib.mkIf config.dunst.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = "(250,300)";
          height = "(0,200)";
          offset = "(14,34)";
          origin = "top-right";
          background = "#282828";
          foreground = "#ebdbb2";
          frame_width = 2;
          font = "JetBrains Nerd Font 9";
          min_icon_size = 16;
          max_icon_size = 32;
          corner_radius = 14;
          timeout = 10;
        };

        urgency_low = {
          frame_color = "#689d6a";
        };
        urgency_normal = {
          frame_color = "#458588";
        };
        urgency_critical = {
          frame_color = "#cc241d";
          timeout = 15;
        };
      };
    };
  };
}
