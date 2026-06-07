{
  config,
  lib,
  pkgs,
  ...
}:
let
  rofi-power-menu = (pkgs.rofi-power-menu).overrideAttrs (oldAttrs: {
    installPhase = ''
      sed -i 's|terminate-session|kill-session|g' rofi-power-menu
    ''
    + oldAttrs.installPhase;
  });
in
{
  options.rofi = {
    enable = lib.mkEnableOption "enable rofi";
    dpi = lib.mkOption {
      type = lib.types.int;
      default = 100;
      description = "dpi settings";
    };
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      modes = [
        "drun"
        "emoji"
        "calc"
      ];
      extraConfig = {
        kb-primary-paste = "Control+V,Shift+Insert";
        kb-secondary-paste = "Control+v,Insert";
        display-drun = "󰣖  drun:";
        display-emoji = "  emoji:";
        display-calc = "󰪚  calc:";
        display-power-menu = "󰐥 power-menu:";
        dpi = config.rofi.dpi;
      };
      terminal = "${pkgs.kitty}/bin/kitty";
      plugins = [
        pkgs.rofi-calc
        pkgs.rofi-emoji
      ];
      theme = ./gruvbox-material.rasi;
    };
    home.packages = [ rofi-power-menu ];
  };
}
