{
  inputs,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./gruvbox
    ./kitty.nix
    ./qtile.nix
    ./tmux
    ./zsh
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  xdg.enable = true;
}
