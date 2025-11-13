{
  config,
  lib,
  pkgsUnstable,
  inputs,
  ...
}:

{

  options = {
    picom.enable = lib.mkEnableOption "enables Picom";
  };

  config = lib.mkIf config.picom.enable {
    services.picom = {
      enable = true;
      package = pkgsUnstable.picom;
      backend = "glx";
      opacityRules = [
        "96:class_g = 'kitty'"
        "85:class_g = 'Rofi'"
        "90:class_g = 'tauonmb'"
        "90:class_g = 'Thunar'"
      ];
      settings = {
        blur = {
          method = "gaussian";
          size = 20;
          deviation = 7.5;
        };
        blur-background-exclude = [
          "window_type = 'menu'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
          "window_type = 'utility'"
          "window_type = 'dnd'"
          "window_type = 'dock'"
          "class_g = 'TelegramDesktop'"
        ];
        wintypes = {
          dock = {
            shadow = false;
          };
          dnd = {
            shadow = false;
          };
          tooltip = {
            shadow = false;
          };
          menu = {
            opacity = false;
          };
          dropdown_menu = {
            opacity = false;
          };
          popup_menu = {
            opacity = false;
          };
          utility = {
            opacity = false;
          };
        };
      };

      vSync = false;
    };
  };
}
