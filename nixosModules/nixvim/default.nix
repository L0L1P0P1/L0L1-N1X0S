{ config, lib, pkgs, pkgsUnstable, inputs, ... }:
{

	options = {
		nixvim.enable =
			lib.mkEnableOption "enables nixvim";
	};

	imports = [
		./keymaps.nix
		./alpha.nix
	];

	config = lib.mkIf config.nixvim.enable {
		
		programs.nixvim = {
			enable = true;
			enableMan = true;

			# Color Schemes
			colorschemes.gruvbox.enable = true;
			
			# Options
			opts = {
				number = true;
				relativenumber = true;
				shiftwidth = 4;
				tabstop = 4;
				fillchars.eob = " ";
			};

			globals = {
				mapleader = " ";
			};

			# Plugins
			plugins = {
				bufferline.enable = true;
				web-devicons.enable = true;
				nvim-autopairs.enable = true;
				tmux-navigator.enable = true;
				neoscroll.enable = true;
				neogit.enable = true;
				gitsigns.enable = true;
				dressing.enable = true;
				noice.enable = true;
				notify.enable = true;
				render-markdown.enable = true;

				vim-dadbod.enable = true;
				vim-dadbod-ui.enable = true;
				vim-dadbod-completion.enable = true;

				indent-blankline = {
					enable = true;
					settings = {
						indent.char = "┊";
						scope = {
							enabled = true;
							show_end = true;
							show_exact_scope = true;
							show_start = true;
						};
					};
				};
				
				which-key = {
					enable = true;
					settings.delay = 400;
				};

				nvim-tree = {
					enable = true;
					ignoreFtOnSetup = ["dashboard" ""]; 
					openOnSetup = true;
					filters.dotfiles = true;
					renderer.groupEmpty = true;
				};


				lualine = {
					enable = true;
					settings.options = {
						ignore_focus = ["NvimTree"];
					};
				};

				telescope = {
					enable = true;
					keymaps = {
						"<C-k>" = {action = "move_selection_previous";};
						"<C-j>" = {action = "move_selection_next";};
						"<C-q>" = {action = "send_selected_to_qflist";}; 
					};
				};

				cmp = {
					enable = true;
					autoEnableSources = true;
					settings = {
						sources = [
							{name = "nvim_lsp";}
							{name = "vim-dadbod-completion";}
							{name = "path";}
							{name = "buffer";}
							{name = "render-markdown";}
						]; 
						mapping = {
							"<C-k>" = "cmp.mapping.select_prev_item()";
							"<C-j>" = "cmp.mapping.select_next_item()";
							"<C-b>" = "cmp.mapping.scroll_docs(-4)";
							"<C-f>" = "cmp.mapping.scroll_docs(4)";
							"<C-space>" = "cmp.mapping.complete()"; 
							"<C-e>" = "cmp.mapping.abort()";
							"<CR>" = "cmp.mapping.confirm({ select = true })";
						};
					};
				};

				lsp-status.enable = true;
				lspkind.enable = true;
				lsp = {
					enable = true;
					inlayHints = true;
					preConfig = ''
							local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
							for type, icon in pairs(signs) do
								local hl = "DiagnosticSign" .. type
								vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
							end
					'';

					servers = {
						rust_analyzer = {
							enable = true;
							installCargo = true;
							installRustc = true;
						};
						clangd = {
							enable = true;
							package = pkgsUnstable.clang-tools;
							cmd = [
								"${pkgsUnstable.clang-tools}/bin/clangd" 
								"--function-arg-placeholders" 
								"--completion-style=detailed"
								"--background-index"
								"--clang-tidy"
								"--header-insertion=iwyu"
								"--fallback-style=llvm"
							]; 
						};
						pylsp.enable = true;
						lua_ls.enable = true;
						nixd.enable = true;
					};
				};	

				treesitter = {
					enable = true;
					settings = {
						auto_install = true;
						highlight.enable = true;
						ensure_installed = [
							"json"
							"javascript"
							"python"
							"cpp"
							"c"
							"rust"
							"lua"
							"nix"
							"sql"
							"vim"
							"regex"
							"bash"
							"markdown"
							"markdown_inline"
						];
					};
				};
			};
			
			# Extra Plugins
			# extraPlugins = [
			# 	pkgsUnstable.vimPlugins.markdown-nvim
			# ];
			# extraConfigLua = "require('markdown').setup({})";
		};
	};
}
