{
  lib,
  inputs,
  config,
  pkgsUnstable,
  ...
}:
{
  options.opencode.enable = lib.mkEnableOption "enables opencode";

  config = lib.mkIf config.opencode.enable {
    environment.systemPackages = [ pkgsUnstable.opencode ];
  };

}
