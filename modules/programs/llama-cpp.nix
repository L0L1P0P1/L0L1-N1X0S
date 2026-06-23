{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.llama-cpp = {
    enable = lib.mkEnableOption "enables llama-cpp";
    llm = lib.mkOption {
      description = "Model Used for llama-cpp";
      type = lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf config.llama-cpp.enable {
    services.llama-cpp = {
      enable = true;
      host = "0.0.0.0";
      port = 6767;
    };
  };

}
