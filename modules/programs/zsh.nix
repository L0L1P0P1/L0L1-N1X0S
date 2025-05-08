{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  options = {
    zshold.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zshold.enable {

    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

    environment.systemPackages = with pkgs; [
      zoxide
      zsh-syntax-highlighting
      zsh-autosuggestions
    ];
  };

}
