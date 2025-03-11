{config, lib, pkgs, pkgsUnstable, inputs, ... } :
{
	
	imports = [
		./arduino.nix
		./latex.nix
	];

	options = {
		devTools.enable =
			lib.mkEnableOption "enables devTools";
	};

	config = lib.mkIf config.devTools.enable {
		
		environment.systemPackages = (with pkgs; [
			tree
			mlocate
			tree-sitter
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
			keychain
			pkg-config
			ntfs3g

			# Enviroments  
			gcc
			clang-tools
			clang
			conda
			cmake
			rustc
			cargo
			rust-analyzer
			lua
			luarocks
			lua-language-server
			lua52Packages.lua-lsp
			nodejs_22 
			manim
		]) ++ (with pkgsUnstable; [
			vim 
		]);
	};



}
