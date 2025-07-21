{
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    gruvbox.enable = lib.mkEnableOption "enables gruvbox themes for gtk and QT";
  };

  config = lib.mkIf config.gruvbox.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
      };
      theme = {
        name = "Gruvbox-Material-Dark";
        package = pkgs.gruvbox-material-gtk-theme;
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
