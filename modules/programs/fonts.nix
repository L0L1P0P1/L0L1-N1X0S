{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.blex-mono
        nerd-fonts.hack
        nerd-fonts.ubuntu-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.lilex
        noto-fonts-color-emoji
        ipafont
        iso-flags
        liberation_ttf
        ibm-plex
        sahel-fonts
        vazir-fonts
        vazir-code-font
      ];
      fontconfig = {
        defaultFonts = {
          serif = [
            "Liberation Serif"
            "Sahel"
          ];
          sansSerif = [ "Sahel" ];
          monospace = [
            "Lilex Nerd Font"
            "Vazir Code"
          ];
        };
        useEmbeddedBitmaps = true;
      };
    };
  };
}
