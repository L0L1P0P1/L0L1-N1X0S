{
  pkgs,
  pkgsUnstable,
  lib,
  config,
  ...
}:
{

  options = {
    cli-tools.enable = lib.mkEnableOption "Enables cli-tools";
  };

  config = lib.mkIf config.cli-tools.enable {
    environment.systemPackages =
      (with pkgs; [
        aria2
        bat
        bluetuith
        brightnessctl
        btop
        btrfs-progs
        coreutils-full
        dig
        dnsmasq
        drill
        dua
        ffmpeg
        gh
        git
        gnumake
        htop
        iwd
        jq
        keychain
        killall
        ldns
        man-pages
        man-pages-posix
        massdns
        mlocate
        net-tools
        nitch
        nix-tree
        nixfmt-rfc-style
        nixpkgs-manual
        nixpkgs-review
        nmap
        ntfs3g
        pandoc
        pkg-config
        rar
        ripgrep
        speedtest-go
        sqlite
        starship
        stdman
        stdmanpages
        stow
        tealdeer
        tree
        tree-sitter
        unzip
        whois
        wget
        xev
        xkbmon
        yazi
        zdns
        zip
        zmap
      ])
      ++ (with pkgsUnstable; [
        nox
      ]);
  };
}
