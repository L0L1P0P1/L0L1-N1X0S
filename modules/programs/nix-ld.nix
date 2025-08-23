{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.nix-ld.enable = lib.mkEnableOption "enables nix-ld";
  
  config = lib.mkIf config.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
      ];    
    };
    services.envfs.enable = true;
  };
}
