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
      clang-manpages
      llvm-manpages
      lldb
      conda
      cmake
      gcc
      go
      rustc
      cargo
      rustup
      rust-analyzer
      libpcap
      lua
      luarocks
      lua-language-server
      lua52Packages.lua-lsp
      nodejs_22
      postgres-language-server
      uv
    ];
  };
}
