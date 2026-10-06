{
  lib,
  config,
  pkgsUnstable,
  ...
}:
{

  options = {
    kitty = {
      enable = lib.mkEnableOption "enables kitty";
      fontSize = lib.mkOption {
        description = "Default Terminal Font Size";
        type = lib.types.int;
        default = 11;
      };
    };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;

      themeFile = "GruvboxMaterialDarkMedium";
      font.name = "Lilex Nerd Font";
      font.size = config.kitty.fontSize;

      settings = {
        confirm_os_window_close = 0;
        disable_ligatures = "cursor";
        enable_audio_bell = false;
      };
    };
  };

}
