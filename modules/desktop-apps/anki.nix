{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.anki = {
    enable = lib.mkEnableOption "enables anki desktop";
  };

  config = {
    environment.systemPackages = [ pkgs.anki ];
  };
}
