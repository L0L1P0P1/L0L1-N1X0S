{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gnome-network-display.enable = lib.mkEnableOption "enable gnome-network-display";

  config = lib.mkIf config.gnome-network-display.enable {
    environment.systemPackages = [ pkgs.gnome-network-displays ];

    networking.firewall = {
      allowedTCPPorts = [
        7236
        7250
      ];
      allowedUDPPorts = [
        7236
        5353
      ];
    };

    xdg.portal.enable = true;
  };
}
