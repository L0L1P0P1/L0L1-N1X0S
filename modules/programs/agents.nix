{
  lib,
  pkgsUnstable,
  config,
  ...
}:
{
  options.agents = {
    enable = lib.mkEnableOption "enables agents";
  };

  config = lib.mkIf config.agents.enable {
    environment.systemPackages = with pkgsUnstable; [
      opencode
      gemini-cli
    ];
  };
}
