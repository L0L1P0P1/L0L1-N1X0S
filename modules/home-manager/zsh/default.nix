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
        "nv" = "nvim";
        "s" = "sesh connect $(sesh list --icons | fzf --ansi --preview 'sesh preview {}')";
        ".." = "cd ../";
        "..." = "cd ../..";
      };
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      dotDir = "${config.xdg.configHome}/zsh";
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

    programs.fd.enable = true;

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

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.git = {
      enable = true;
    };

    programs.dircolors = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        OTHER_WRITABLE = "01;34;04";
        ".sh" = "01;32";
        ".csh" = "01;32";
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;

      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
      defaultOptions = [
        "--tmux center,60% "
        "--layout reverse "
        "--inline-info "
        "--preview 'bat -n --color=always {}' "
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
        "--bind 'ctrl-h:reload:fd --type f -H'"
      ];
      historyWidgetOptions = [
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'"
        "--color header:italic"
        "--header 'Press CTRL-Y to copy command into clipboard'"
        "--preview-window hidden"
      ];
      changeDirWidgetOptions = [ "--preview 'tree -C {}'" ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        command_timeout = 36000;
        format = ''
          [┌──────](bold green) $all[└─](bold green) $jobs$username$hostname$character
        '';
        cmd_duration = {
          min_time = 800;
          show_milliseconds = false;
        };
        username = {
          show_always = true;
          format = "[$user]($style)";
          style_root = "italic bold red";
          style_user = "italic bold blue";
        };
        hostname = {
          format = "[@$hostname](italic bold blue) ";
          ssh_only = false;
        };
        character = {
          success_symbol = "[⤳](bold green)";
          error_symbol = "[⤳](bold red)";
        };
      };
    };
  };
}
