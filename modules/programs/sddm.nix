{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "japanese_aesthetic";
    themeConfig = {
      AllowUppercaseLettersInUsernames = true;
    };
  };
in
{
  options.sddm.enable = lib.mkEnableOption "enables sddm";

  config = lib.mkIf config.sddm.enable {
    environment.systemPackages = [
      sddm-astronaut
    ];
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
      ];
      theme = "sddm-astronaut-theme";
      settings.Theme.Current = "sddm-astronaut-theme";
    };
  };
}
