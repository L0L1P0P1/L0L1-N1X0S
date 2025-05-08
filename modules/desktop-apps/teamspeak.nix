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
    environment.systemPackages = [
      pkgs.teamspeak3
    ];

  };
}
