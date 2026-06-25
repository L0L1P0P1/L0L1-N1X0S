{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  llama-cpp = (pkgsUnstable.llama-cpp.override { cudaSupport = true; });
in
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
      enable = false;
      host = "0.0.0.0";
      port = 6767;
      package = llama-cpp;

      modelsDir = "/models/";

      modelsPreset = {
        "gemma-4-12B-agentic-v2" = {
          hf-repo = "yuxinlu1/gemma-4-12B-agentic-fable5-composer2.5-v2-3.5x-tau2-GGUF";
          hf-file = "gemma4-v2-Q4_K_M.gguf";
        };
      };
    };

    environment.systemPackages = [ llama-cpp ];
  };

}
