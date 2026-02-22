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
    ./easyeffects.nix
    ./gruvbox
    ./kdeconnect.nix
    ./kitty.nix
    ./picom.nix
    ./qtile.nix
    ./tmux
    ./zsh
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  xdg.enable = true;
}
