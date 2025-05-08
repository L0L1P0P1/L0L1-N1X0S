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
      nixpkgs-review
      ntfs3g
      pkg-config
      rar
      ripgrep
      starship
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
