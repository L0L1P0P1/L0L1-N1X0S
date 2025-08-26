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
      customPaneNavigationAndResize = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      prefix = "C-space";
      terminal = "tmux-256color";
      shell = "${pkgsUnstable.zsh}/bin/zsh";

      extraConfig = ''
        # Status Bar Position
        set-option -g status-position top

        # Split in Current Directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"

        # Source tmux 
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      '';

      plugins = with pkgsUnstable.tmuxPlugins; [
        {
          plugin = pkgsUnstable.callPackage (
            { fetchFromGitHub }:
            pkgsUnstable.tmuxPlugins.mkTmuxPlugin {
              pluginName = "tmux-gruvbox";
              rtpFilePath = "gruvbox.tmux";
              version = "1.0"; 
              src = fetchFromGitHub {
                owner = "z3z1ma";
                repo = "tmux-gruvbox";
                rev = "8f71abd479e60f9a663abdc42e06491b7e8e6a25"; 
                sha256 = "wBhOKM85aOcV4jD7wdyB/zXKDdhODE5k1iud+cm6Wk0="; 
              };
            }
          ) {};
          extraConfig = ''
            # gruvbox 
            set -ga terminal-overrides ",xterm-256color:Tc"
            set -g @gruvbox_flavour 'material'
            set -g @gruvbox_window_left_separator "█"
            set -g @gruvbox_window_right_separator "█ "
            set -g @gruvbox_window_number_position "right"
            set -g @gruvbox_window_middle_separator "  █"

            set -g @gruvbox_window_default_fill "number"

            set -g @gruvbox_window_current_fill "number"
            set -g @gruvbox_window_current_text "#{b:pane_current_path}"

            set -g @gruvbox_status_modules_right "application session date_time"
            set -g @gruvbox_status_left_separator  ""
            set -g @gruvbox_status_right_separator " "
            set -g @gruvbox_status_right_separator_inverse "yes"
            set -g @gruvbox_status_fill "all"
            set -g @gruvbox_status_connect_separator "no"
          '';
        }
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
        {
          plugin = cpu;
        }
        {
          plugin = yank;
        }
        {
          plugin = sensible;
        }
        {
          plugin = vim-tmux-navigator;
        }
      ];
    };
  };

}
