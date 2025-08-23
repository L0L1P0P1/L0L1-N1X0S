{
  config,
  lib,
  pkgsUnstable,
  ...
}:
{

  options = {
    tmux.enable = lib.mkEnableOption "Enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.sesh = {
      enable = true;
      package = pkgsUnstable.sesh;
      enableAlias = false;
    };
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      prefix = "C-space";
      shell = "${pkgsUnstable.zsh}/bin/zsh";

      extraConfig = ''
        # Status Bar Position
        set-option -g status-position top

        # Split in Current Directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"
      '';

      plugins = with pkgsUnstable.tmuxPlugins; [
        cpu
        yank
        sensible
        vim-tmux-navigator
        gruvbox
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '5'
          '';
        }
      ];
    };
  };

}
