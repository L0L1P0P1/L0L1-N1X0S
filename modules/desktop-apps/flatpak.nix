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
      overrides = {
        global = {
          Environment = {
            "XCURSOR_PATH" = "/run/host/user-share/icons:/run/host/share/icons";
            "QT_STYLE_OVERRIDE" = "kvantum";
          };
        };
        "com.teamspeak.TeamSpeak3".Context = {
          env = [
            "QT_STYLE_OVERRIDE=kvantum"
          ];
          filesystems = [
            "/home/L0L1P0P/.config/Kvantum:ro"
            "/home/L0L1P0P/Pictures:ro"
          ];
        };
      };
      packages = [
        "runtime/org.kde.KStyle.Kvantum/x86_64/5.15"
        "io.github.giantpinkrobots.varia"
      ]
      ++ lib.optional config.flatpak.teamspeak3.enable "com.teamspeak.TeamSpeak3"
      ++ lib.optional config.flatpak.stremio.enable "com.stremio.Stremio";
    };
    xdg.portal = {
      enable = true;
      config.common.default = "*";
    };

    networking.extraHosts = lib.mkIf config.flatpak.teamspeak3.enable ''
      127.0.0.1 blacklist.teamspeak.com
      127.0.0.1 blacklist2.teamspeak.com
    '';
  };
}
