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
    ./docker.nix
    ./environments.nix
    ./latex.nix
    ./nix-ld.nix
    ./pdfTools.nix
    ./sddm.nix

    ./nixvim
  ];
}
