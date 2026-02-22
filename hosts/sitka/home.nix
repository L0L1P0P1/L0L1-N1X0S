{ config, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager
  ];

  # User
  home.username = "L0L1P0P";
  home.homeDirectory = "/home/L0L1P0P";

  # environment.
  home.packages = [
    # user packages
  ];

  home.enableNixpkgsReleaseCheck = false;

  betterlockscreen = {
    enable = true;
    arguments = [
      "dimblur"
      "--show-layout"
    ];
  };

  easyeffects.enable = true;
  cursor-theme.enable = true;
  gruvbox.enable = true;
  kdeconnect.enable = true;
  kitty.enable = true;
  picom.enable = true;
  tmux.enable = true;
  zsh.enable = true;

  qtile = {
    enable = true;
    margin = 8;
    borderWidth = 0;
    autostartOnce = ''
      #!/usr/bin/env bash

      openrgb --startminimized &
      clash-verge & 
      lxqt-policykit-agent &
    '';
  };

  home.file = {
    # home-manager files to handle
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Do Not Touch or NixGODs will condemn you to eternal suffering
  home.stateVersion = "24.11";
}
