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
      vSync = false;

      opacityRules = [
        "100:fullscreen"
        "100:QTILE_INTERNAL = 1"
        "90:class_g = 'kitty'"
        "85:class_g = 'Rofi'"
        "90:class_g = 'tauonmb'"
        "90:class_g = 'Thunar'"
        "95:class_g = 'obsidian'"
        "95:class_g = 'sioyek'"
      ];

      shadow = true;
      shadowExclude = [
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'"
        "window_type = 'utility'"
        "window_type = 'dnd'"
        "window_type = 'dock'"
        "class_g = 'TelegramDesktop'"
      ];

      fade = true;
      fadeDelta = 5;
      fadeSteps = [
        0.02
        0.02
      ];

      settings = {
        no-fading-openclose = true;
        inactive-dim = 0.14;

        corner-radius = 14;
        rounded-corners-exclude = [ "class_g *= 'olybar'" ];

        blur = {
          method = "dual_kawase";
          strength = 5;
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

        # some settings to fix flickering and stuff
        unredir-if-possible = false;
        xrender-sync-fence = false;
        use-damage = false;
        glx-no-stencil = true;
        detect-transient = true;
        use-ewmh-active-win = true;
        detect-rounded-corners = true;
        mark-wmwin-focused = false;
        dithered-present = false;
      };

      extraConfig = ''
        animations = (
          {
            triggers = ["close"];
            opacity = {
              curve = "cubic-bezier(0,0,1,-0.28)";
              duration = .2; 
              start = "window-raw-opacity-before";
              end = 0;
            };
            blur-opacity = "opacity";
            shadow-opacity = "opacity";
            offset-x = "(1 - scale-x) / 2 * window-width";
            offset-y = "(1 - scale-y) / 2 * window-height";
            scale-x = {
              curve = "cubic-bezier(0,0,1,-0.28)";
              duration = .2;
              start = 1;
              end = .5;
            };
            scale-y = "scale-x";
            shadow-scale-x = "scale-x";
            shadow-scale-y = "scale-y";
            shadow-offset-x = "offset-x";
            shadow-offset-y = "offset-y";
          },
          {
            triggers = ["open"];
            opacity = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = .2;
              start = 0;
              end = "window-raw-opacity";
            }
            blur-opacity = "opacity";
            shadow-opacity = "opacity";
            offset-x = "(1 - scale-x) / 2 * window-width";
            offset-y = "(1 - scale-y) / 2 * window-height";
            scale-x = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = .2;
              start = .5;
              end = 1;
            };
            scale-y = "scale-x";
            shadow-scale-x = "scale-x";
            shadow-scale-y = "scale-y";
            shadow-offset-x = "offset-x";
            shadow-offset-y = "offset-y";
          },
          {
            triggers = ["geometry"]
            scale-x = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = 0.22;
              start = "window-width-before / window-width";
              end = 1;
            }
            scale-y = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = 0.22;
              start = "window-height-before / window-height";
              end = 1;
            }
            offset-x = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = 0.22;
              start = "window-x-before - window-x";
              end = 0;
            }
            offset-y = {
              curve = "cubic-bezier(0,1.28,1,1)";
              duration = 0.22;
              start = "window-y-before - window-y";
              end = 0;
            }

            shadow-scale-x = "scale-x";
            shadow-scale-y = "scale-y";
            shadow-offset-x = "offset-x";
            shadow-offset-y = "offset-y";
          }
        )
      '';
    };
  };
}
