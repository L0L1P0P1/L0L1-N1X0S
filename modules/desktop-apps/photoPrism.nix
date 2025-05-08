{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    photoPrism.enable = lib.mkEnableOption "enables photoPrism";
  };

  config = lib.mkIf config.photoPrism.enable {
    services.photoprism = {
      enable = true;
      originalsPath = "/var/lib/private/photoprism/originals";
      address = "0.0.0.0";
      port = 2342;
      settings = {
        PHOTOPRISM_ADMIN_USER = "badeli";
        PHOTOPRISM_ADMIN_PASSWORD = "123";
        PHOTOPRISM_DEFAULT_LOCALE = "en";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "http://sub.domain.tld:2342";
        PHOTOPRISM_SITE_TITLE = "Behrad's Photo Prism";
      };
    };

    services.mysql = {
      enable = true;
      dataDir = "/data/mysql";
      package = pkgs.mariadb;
      ensureDatabases = [ "photoprism" ];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
  };
}
