{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:

{

  imports = [
    ./clash-verge.nix
    ./droidcamOBS.nix
    ./gaming.nix
    ./heroic.nix
    ./immich.nix
    ./libreOffice.nix
    ./nekoray.nix
    ./photoPrism.nix
    ./picom.nix
    ./steam.nix
    ./tauon.nix
    ./teamspeak.nix
    ./virtualbox.nix
  ];

  options = {
    desktopApps.enable = lib.mkEnableOption "enables desktopApps";
  };

  config = lib.mkIf config.desktopApps.enable {

    environment.systemPackages =
      (with pkgs; [
        # From Stable Channel
        brave
        syncthing
        vlc
        sioyek
        xfce.thunar
        puddletag
        maim

        polybarFull
        rofi
        rofi-power-menu
        networkmanager_dmenu
        papirus-icon-theme

        localsend
        pwvucontrol
        nitrogen
        qpwgraph
        alsa-utils
        xclip
      ])
      ++ (with pkgsUnstable; [
        # From Unstable Channel
        persepolis
        telegram-desktop
        kitty
        vesktop
        obsidian
      ]);
  };

}
