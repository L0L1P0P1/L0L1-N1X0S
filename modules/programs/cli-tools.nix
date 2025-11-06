{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    cli-tools.enable = lib.mkEnableOption "Enables cli-tools";
  };

  config = lib.mkIf config.cli-tools.enable {
    environment.systemPackages = with pkgs; [
      bat
      bluetuith
      btop
      btrfs-progs
      busybox
      dnsmasq
      dua
      gh
      git
      gnumake
      htop
      keychain
      killall
      man-pages
      mlocate
      nitch
      nixfmt-rfc-style
      nixpkgs-manual
      nix-tree
      nixpkgs-review
      ntfs3g
      pkg-config
      rar
      ripgrep
      sqlite
      starship
      stdman
      stdmanpages
      stow
      tealdeer
      tree
      tree-sitter
      unzip
      wget
      zip
    ];
  };
}
