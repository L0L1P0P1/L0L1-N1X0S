{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  sddm-astronaut =
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "japanese_aesthetic";
      themeConfig = {
        AllowUppercaseLettersInUsernames = true;
        Background = "Backgrounds/veryrockman.png";

        HeaderTextColor = "#d5c4a1";
        DateTextColor = "#d5c4a1";
        TimeTextColor = "#d5c4a1";
        LoginFieldBackgroundColor = "#d5c4a1";
        PasswordFieldBackgroundColor = "#d5c4a1";
        LoginFieldTextColor = "#d5c4a1";
        PasswordFieldTextColor = "#d5c4a1";
        UserIconColor = "#d5c4a1";
        PasswordIconColor = "#d5c4a1";
        LoginButtonTextColor = "#504945";
        LoginButtonBackgroundColor = "#d5c4a1";
        SystemButtonsIconsColor = "#42413a";
        SessionButtonTextColor = "#42413a";
        VirtualKeyboardButtonTextColor = "#504945";
        HoverSystemButtonsIconsColor = "#d5c4a1";
        HoverSessionButtonTextColor = "#d5c4a1";
        HighlightTextColor = "#d5c4a1";
        PlaceholderTextColor = "#928374";
        WarningColor = "#d5c4a1";
      };
    }).overrideAttrs
      (oldAttrs: {
        installPhase = oldAttrs.installPhase + ''
          chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
          cp ${./veryrockman.png} $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/veryrockman.png
        '';
      });
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
