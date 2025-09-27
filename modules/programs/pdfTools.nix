{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pdfTools.enable = lib.mkEnableOption "enable pdftools";

  config = lib.mkIf config.pdfTools.enable {
    environment.systemPackages = with pkgs; [
      ocrmypdf
      tocpdf
    ];
  };
}
