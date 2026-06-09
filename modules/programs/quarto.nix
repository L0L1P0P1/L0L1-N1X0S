{
  config,
  lib,
  pkgs,
  ...
}:
let
  version = "1.8.26";
  quarto = pkgs.quarto.overrideAttrs (oldAttrs: {
    inherit version;
    src = pkgs.fetchurl {
      url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-linux-amd64.tar.gz";
      hash = "sha256-rYyqbTrsw/K2pKj7gpZnfvLvlBCkij7rp7H5ockQAPA=";
    };

  });
in
{
  options.quarto.enable = lib.mkEnableOption "enable custom quarto version";

  config = lib.mkIf config.quarto.enable {
    environment.systemPackages = [
      quarto
    ];
  };
}
