{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.fluxer.enable = lib.mkEnableOption "enables fluxer";

  config = lib.mkIf config.fluxer.enable {
    environment.systemPackages = [
      pkgs.fluxer-canary
      pkgs.fluxer
    ];
  };
}
