{ config, lib, pkgs, inputs, ... }:
{

	options = {
		zsh.enable = lib.mkEnableOption "enables zsh";
	};

	config = lib.mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;
			enableCompletion = true;
			enableLsColors = true;

			syntaxHighlighting = {
				enable = true;
			};
			autosuggestions = {
				enable = true;
			};
		};

		programs.starship = {
			enable = true;	
			enableZshIntegration= true;
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
			changeDirWidgetCommand =	"--preview 'tree -C {}'";
		};
	};
}
