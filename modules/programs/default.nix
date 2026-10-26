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
    ./agents.nix
    ./arduino.nix
    ./audacity.nix
    ./cli-tools.nix
    ./docker.nix
    ./environments.nix
    ./latex.nix
    ./llama-cpp.nix
    ./nix-ld.nix
    ./opencode.nix
    ./pdfTools.nix
    ./platformio.nix
    ./quarto.nix
    ./sddm

    ./nixvim
  ];
}
