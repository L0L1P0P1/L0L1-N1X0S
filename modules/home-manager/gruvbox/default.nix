{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  gruvbox = pkgsUnstable.gruvbox-gtk-theme.override {
    colorVariants = [ "dark" ];
    sizeVariants = [ "compact" ];
    themeVariants = [ "teal" ];
    tweakVariants = [
      "medium"
      "macos"
      "float"
    ];
  };
in
{

  options = {
    gruvbox.enable = lib.mkEnableOption "enables gruvbox themes for gtk and QT";
  };

  config = lib.mkIf config.gruvbox.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgsUnstable.gruvbox-material-gtk-theme;
        name = "Gruvbox-Material-Dark";
      };
      theme = {
        name = "Gruvbox-Teal-Dark-Compact-Medium";
        package = gruvbox;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    xdg.configFile = {
      "Kvantum/Gruvbox-Dark-Brown".source = ./Gruvbox-Dark-Brown;
      "Kvantum/kvantum.kvconfig".text = "theme=Gruvbox-Dark-Brown";
    };

    # home.sessionVariables = {
    #   QT_STYLE_OVERRIDE = lib.mkForce "qt6ct-style";
    # };

  };

}
