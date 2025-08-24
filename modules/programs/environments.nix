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
      gcc
      clang-tools
      clang
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
