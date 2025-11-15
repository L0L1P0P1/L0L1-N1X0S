{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];

  # User
  home.username = "L0L1P0P";
  home.homeDirectory = "/home/L0L1P0P";

  # environment.
  home.packages = [
    # home packages
  ];

  home.enableNixpkgsReleaseCheck = false;
  betterlockscreen = {
    enable = true;
    arguments = [
      "dimblur"
      "--show-layout"
    ];
  };
  cursor-theme.enable = true;
  gruvbox.enable = true;
  tmux.enable = true;
  zsh.enable = true;

  kitty = {
    enable = true;
    fontSize = 16;
  };

  qtile = {
    enable = true;
    autostartOnce = ''
      #!/usr/bin/env bash

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
    SHELL = "${pkgsUnstable.zsh}/bin/zsh";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Do Not Touch or NixGODs will condemn you to eternal suffering
  home.stateVersion = "24.11";
}
