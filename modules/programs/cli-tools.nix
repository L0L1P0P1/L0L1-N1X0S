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
        dmenu
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
        libnotify
        man-pages
        man-pages-posix
        masscan
        massdns
        mlocate
        net-tools
        nitch
        nixfmt-rfc-style
        nix-index
        nixpkgs-manual
        nixpkgs-review
        nix-tree
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
        wget
        whois
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
