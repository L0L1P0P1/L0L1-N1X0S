{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    teamspeak.enable = lib.mkEnableOption "enables Teamspeak";
  };

  config = lib.mkIf config.teamspeak.enable {
    networking.extraHosts = ''
      127.0.0.1 blacklist.teamspeak.com
      127.0.0.1 blacklist2.teamspeak.com
    '';

    environment.systemPackages = [
      pkgs.teamspeak6-client
    ];

  };
}
