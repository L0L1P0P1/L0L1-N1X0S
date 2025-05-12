{ config, lib, ... }:
{

  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    home = {
      shell.enableZshIntegration = true;
      shellAliases = {
        "ls" = "ls --color";
        "cd" = "z";
        ".." = "cd ../";
        "..." = "cd ../..";
      };
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      syntaxHighlighting = {
        enable = true;
      };
      autosuggestion = {
        enable = true;
      };
      initExtraFirst = ''
        bindkey -e
      '';
      initExtra = ''
        eval $(keychain -q --nogui --eval --agents ssh ~/.ssh/id_ed25519)
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        command_timeout = 36000;
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;

      defaultOptions = [
        "--tmux center,60% "
        "--layout reverse "
        "--inline-info "
        "--preview 'bat -n "
        "--color=always {}' "
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
      ];
      historyWidgetOptions = [
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
        "--color header:italic"
        "--header 'Press CTRL-Y to copy command into clipboard'"
        "--preview-window hidden"
      ];
      changeDirWidgetOptions = [ "--preview 'tree -C {}'" ];
    };
  };
}
