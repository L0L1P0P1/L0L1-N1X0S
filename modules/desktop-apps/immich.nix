{
  config,
  lib,
  pkgsUnstable,
  ...
}:
{
  options = {
    immich.enable = lib.mkEnableOption "enables immich";
  };

  config = lib.mkIf config.immich.enable {
    services.immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      openFirewall = true;
      package = pkgsUnstable.immich;
    };
    users.users.immich.extraGroups = [
      "video"
      "render"
    ];
  };
}
