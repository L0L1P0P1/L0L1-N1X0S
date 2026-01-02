{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    environments.enable = lib.mkEnableOption "enables devenvs";
  };

  config = lib.mkIf config.environments.enable {
    environment.systemPackages = with pkgs; [
      clang
      clang-tools
      llvm-manpages
      conda
      cmake
      rustc
      cargo
      rust-analyzer
      lua
      luarocks
      lua-language-server
      lua52Packages.lua-lsp
      nodejs_22
      uv
    ];
  };
}
