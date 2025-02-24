{config, lib, pkgs, pkgsUnstable, inputs, ... } :
{
	
	imports = [
		./arduino.nix
	];

	options = {
		devTools.enable =
			lib.mkEnableOption "enables devTools";
	};

	config = lib.mkIf config.devTools.enable {
		
		environment.systemPackages = with pkgs; [
			tree
			mlocate
			tree-sitter
			vim 
			git
			wget
			ripgrep
			htop
			btop
			zip
			bat
			unzip
			rar
			stow
			tldr
			man-pages
			gnumake
			nitch
			starship
			killall
			pkg-config
			ntfs3g
			nix-output-monitor
			nix-fast-build

			# Enviroments  
			gcc
			clang-tools
			clang
			cmake
			rustc
			cargo
			rust-analyzer
			lua
			luarocks
			lua-language-server
			lua52Packages.lua-lsp
			pylint
			nodejs_22 
		];
	};



}
