{
  inputs,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./betterlockscreen.nix
    ./cursor-theme.nix
    ./dunst.nix
    ./easyeffects.nix
    ./gruvbox
    ./kdeconnect.nix
    ./kitty.nix
    ./picom.nix
    ./qtile
    ./rofi
    ./tmux
    ./zsh
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  xdg.enable = true;
}
