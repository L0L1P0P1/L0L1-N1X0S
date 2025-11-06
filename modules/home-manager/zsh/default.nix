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
        "s" = "sesh connect $(sesh list --icons | fzf --ansi --preview 'sesh preview {}')";
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
      localVariables = {
        TERM = "xterm-256color";
      };
      initContent =
        let
          zshConfigEarlyInit = lib.mkOrder 500 ''bindkey -e'';
        in
        lib.mkMerge [
          zshConfigEarlyInit
        ];
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        compression = false;
        addKeysToAgent = "yes";
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        userKnownHostsFile = "~/.ssh/known_hosts";
        hashKnownHosts = false;
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlMaster = "no";
        controlPersist = "no";
      };
    };

    services.ssh-agent.enable = true;

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
        "--preview 'bat -n --color=always {}' "
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
      ];
      historyWidgetOptions = [
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'"
        "--color header:italic"
        "--header 'Press CTRL-Y to copy command into clipboard'"
        "--preview-window hidden"
      ];
      changeDirWidgetOptions = [ "--preview 'tree -C {}'" ];
    };
  };
}
