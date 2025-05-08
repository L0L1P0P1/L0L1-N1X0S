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
    ./arduino.nix
    ./audacity.nix
    ./cli-tools.nix
    ./environments.nix
    ./latex.nix
    ./zsh.nix

    ./nixvim
    # ./tmux
  ];
}
