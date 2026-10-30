{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gnome-network-displays.enable = lib.mkEnableOption "enable gnome-network-displays";

  config = lib.mkIf config.gnome-network-displays.enable {
    environment.systemPackages = [ pkgs.gnome-network-displays ];

    networking.firewall = {
      trustedInterfaces = [ "p2p-wl+" ];
      allowedTCPPorts = [
        7236
        7250
        8009
      ];
      allowedUDPPorts = [
        7236
        5353
      ];

      allowedUDPPortRanges = [
        {
          from = 32768;
          to = 60999;
        }
      ];
    };

    xdg.portal.enable = true;
  };
}
