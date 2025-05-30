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
    ./picom.nix
    ./tauon.nix
    ./virtualbox.nix
    ./heroic.nix
    ./libreOffice.nix
    ./photoPrism.nix
    ./immich.nix
    ./teamspeak.nix
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
        nekoray
        telegram-desktop

        kitty
        vesktop
        obsidian
      ]);
  };

}
