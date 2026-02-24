{
  lib,
  config,
  options,
  pkgs,
  pkgsUnstable,
  ...
}:
{

  options = {
    qtile = {
      enable = lib.mkEnableOption "enables qtile";
      borderWidth = lib.mkOption {
        description = "Window Border Widths";
        type = lib.types.int;
        default = 5;
      };
      margin = lib.mkOption {
        description = "Window Margins";
        type = lib.types.int;
        default = 10;
      };
      barScale = lib.mkOption {
        description = "Bar GUI Scale";
        type = lib.types.float;
        default = 1.0;
      };
      batteryWidget = lib.mkOption {
        description = "To turn on Battery Widget";
        type = lib.types.bool;
        default = false;
      };
      autostart = lib.mkOption {
        description = "Shellscript To Run Eachtime Qtile is Restarted";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nitrogen --restore &
          # /home/L0L1P0P/.config/polybar/launch.sh &
          setxkbmap -layout us,ir -option 'grp:alt_shift_toggle' &
        '';
      };
      autostartOnce = lib.mkOption {
        description = "Shellscript to Run Once On Login";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nm-applet &
          clash-verge-rev &
          lxqt-policykit-agent &
        '';
      };
    };
  };

  config = lib.mkIf config.qtile.enable {
    xdg.configFile = {
      "qtile/autostart.sh" = {
        text = ''${config.qtile.autostart}'';
        executable = true;
      };
      "qtile/autostart_once.sh" = {
        text = ''${config.qtile.autostartOnce}'';
        executable = true;
      };
      "qtile/screenshot.sh" = {
        text = ''
          #!/usr/bin/env bash
          maim -o -s | tee ~/Pictures/screenshots/$(date +%s).png | xclip -selection clipboard -t image/png
        '';
        executable = true;
      };

      "qtile/options.toml".source = (pkgs.formats.toml { }).generate "something" {
        margin = config.qtile.margin;
        border_width = config.qtile.borderWidth;
        bar_scale = config.qtile.barScale;
        battery_widget = config.qtile.batteryWidget;
      };
      "qtile/config.py".source = ./config.py;
    };
  };
}
