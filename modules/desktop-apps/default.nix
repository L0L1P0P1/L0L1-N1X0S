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
    ./gimp.nix
    ./flatpak.nix
    ./immich.nix
    ./kdenlive.nix
    ./libreOffice.nix
    ./photoPrism.nix
    ./tauon.nix
    ./teamspeak.nix
    ./throne.nix
    ./virtualbox.nix
  ];

  options = {
    desktopApps.enable = lib.mkEnableOption "enables desktopApps";
  };

  config = lib.mkIf config.desktopApps.enable {

    environment.systemPackages =
      (with pkgs; [
        # From Stable Channel
        arandr
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
        pdf4qt
        nicotine-plus

        localsend
        pwvucontrol
        nitrogen
        qpwgraph
        helvum
        alsa-utils
        nsxiv
        xclip
        zoom-us
      ])
      ++ (with pkgsUnstable; [
        # From Unstable Channel
        telegram-desktop
        kitty
        vesktop
        obsidian
        v2rayn
      ]);
  };

}
