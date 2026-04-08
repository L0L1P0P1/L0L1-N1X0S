{
  config,
  lib,
  pkgsUnstable,
  inputs,
  ...
}:

{

  options = {
    picom = {
      enable = lib.mkEnableOption "enables Picom";
      cornerRadius = lib.mkOption {
        description = "Corner Radius for Rounded Corners";
        type = lib.types.int;
        default = 14;
      };
    };
  };

  config = lib.mkIf config.picom.enable {
    services.picom = {
      enable = true;
      package = pkgsUnstable.picom;
      backend = "glx";

      vSync = false;
      shadow = true;
      fade = true;
      fadeDelta = 5;
      fadeSteps = [
        0.02
        0.02
      ];

      settings = {
        no-fading-openclose = true;
        corner-radius = config.picom.cornerRadius;

        blur = {
          method = "dual_kawase";
          strength = 5;
        };

        # some settings to fix flickering and stuff
        unredir-if-possible = false;
        xrender-sync-fence = false;
        use-damage = false;
        glx-no-stencil = true;
        detect-transient = true;
        use-ewmh-active-win = true;
        detect-rounded-corners = true;
        dithered-present = false;
      };

      extraConfig = ''
        rules: (
          { match = "QTILE_INTERNAL = 1"; corner-radius = 0; },
          { match = "QTILE_INTERNAL = 1"; opacity = 1.0; },
          { match = "class_g = 'obsidian'"; opacity = 0.95; },
          { match = "class_g = 'sioyek'"; opacity = 0.95; },
          { match = "class_g = 'kitty' || class_g = 'yazi' || class_g = 'nvim'"; opacity = 0.9; },
          { match = "class_g = 'tauonmb'"; opacity = 0.9; },
          { match = "class_g = 'Thunar'"; opacity = 0.9; },
          { match = "class_g = 'Rofi'"; opacity = 0.85;},
          { match = "fullscreen"; opacity = 1.0; corner-radius = 0; },
          { match = "!focused || !group_focused"; dim = 0.14; },
          {
            match = "window_type = 'menu' 
                    || window_type = 'dropdown_menu' 
                    || window_type = 'popup_menu' 
                    || window_type = 'utility' 
                    || window_type = 'dnd' 
                    || window_type = 'dock'
                    || class_g = 'TelegramDesktop'";
            blur-background = false; 
            shadow = false;
          },
          {
            match = "class_g = 'slop' || QTILE_INTERNAL = 1";
            animations = (
              {
                  triggers = [ "open", "show" ];
                  duration = 0;
              },
              {
                  triggers = [ "close", "hide" ];
                  duration = 0;
              }
            );
          },
          {
            match = "class_g = 'Dunst'";
            opacity = 0.8;
            blur-background = true;
            shadow = true;
            animations = (
            {
                triggers = ["open", "show"];
                offset-x = "(1 - scale-x) / 2 * window-width";
                offset-y = "(1 - scale-y) / 2 * window-height";
                scale-x = {
                  curve = "cubic-bezier(0,1.28,1,1)";
                  duration = 0.8;
                  start = .65;
                  end = 1;
                };
                scale-y = "scale-x";
            },
            );
          }
        )

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
