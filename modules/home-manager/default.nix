{
  inputs,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./zsh
    ./tmux
    ./kitty.nix
    ./qtile.nix
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  xdg.enable = true;
}
