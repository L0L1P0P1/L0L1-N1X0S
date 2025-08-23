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
    ./nix-ld.nix

    ./nixvim
  ];
}
