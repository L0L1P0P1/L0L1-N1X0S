{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.blender.enable = lib.mkEnableOption "enables blender";

  config = lib.mkIf config.blender.enable {
    environment.systemPackages = with pkgs; [
      blender
    ];
  };
}
