{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    flatpak.enable = lib.mkEnableOption "enables flatpak on host";
    flatpak.stremio.enable = lib.mkEnableOption "enables stremio flakpak";
    flatpak.teamspeak3.enable = lib.mkEnableOption "enables teamspeak3 flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        # flatpak packages
      ]
      ++ lib.optional config.flatpak.teamspeak3.enable "com.teamspeak.TeamSpeak3"
      ++ lib.optional config.flatpak.stremio.enable "com.stremio.Stremio";
    };
    xdg.portal = {
      enable = true;
      config.common.default = "*";
    };
  };
}
