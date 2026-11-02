{
  lib,
  config,
  pkgsUnstable,
  ...
}:
{
  options.typst.enable = lib.mkEnableOption "enable typst";

  config = lib.mkIf config.typst.enable {
    environment.systemPackages = with pkgsUnstable; [
      typst
      typstyle
    ];
  };
}
