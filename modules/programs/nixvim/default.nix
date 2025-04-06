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
				render-markdown.enable = true;
				vim-dadbod.enable = true;
				vim-dadbod-ui.enable = true;
				vim-dadbod-completion.enable = true;

				presence-nvim = {
					enable = true;
				};

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
					updateFocusedFile = {
						enable = true;
						updateRoot = true;
					};
				};

				lualine = {
					enable = true;
					package = pkgs.vimPlugins.lualine-nvim;
				};

				telescope = {
					enable = true;
					extensions = {
						file-browser.enable = true;
					};
					keymaps = {
						"<C-q>" = {action = "send_selected_to_qflist"; mode = ["i" "n"];}; 
					};
					settings.mappings = {
						i = {
							"<C-j>" = {
								__raw = "require('telescope.actions').move_selection_next";
							};
							"<C-k>" = {
								__raw = "require('telescope.actions').move_selection_previous";
							};
						};
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
						vim.diagnostic.config {
						  virtual_text = true,
						  signs = {
							text = {
							  [vim.diagnostic.severity.ERROR] = "",
							  [vim.diagnostic.severity.WARN] = "",
							  [vim.diagnostic.severity.INFO] = "󰋼",
							  [vim.diagnostic.severity.HINT] = "󰌵",
							},
						  },
						  float = {
							border = "rounded",
							format = function(d)
							  return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
							end,
						  },
						  underline = true,
						  jump = {
							float = true,
						  },
						}
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

						# pylsp = {
						# 	enable = true;
						# 	settings.plugins = {
						# 		autopep8.enable = true;
						# 		black.enable = true;
						# 		flake8.enable = true;
						# 		pylint.enable = true;
						# 		isort.enable = true;
						# 		pycodestyle.enable = true;
						# 		jedi_completion = {
						# 			enable = true;
						# 			cache_for = ["manim" "manimlib" "matplotlib" "numpy" "pandas"];
						# 		};
						# 		jedi_references.enable = true;
						# 		jedi_hover.enable = true;
						# 	};
						# };

						pyright = {
							enable = true;
							package = pkgsUnstable.pyright;
							cmd = [
								"${pkgsUnstable.pyright}/bin/pyright-langserver"
								"--stdio"
								"--pythonpath"
								"$(eval \"which python\")"
							];
							# settings = {
							# 	pythonPath = {__raw = ''vim.fn.exepath("python")'';};
							# };
						};
						lua_ls.enable = true;
						nixd.enable = true;
					};
				};	

				# none-ls = {
				# 	enable = true;
				# 	sources.diagnostics = {
				# 		pylint.enable = true;
				# 	};
				# };

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

				notify = {
					enable = true;
					settings = {
						background_colour = "#000000";
						render = "wrapped-compact";
						fps = 60;
						stages = "slide";
					};
				};
			};
			
			# Extra Plugins
			# extraPlugins = [
			# 	pkgsUnstable.vimPlugins.cord-nvim
			# ];
			# extraConfigLua = "require('cord').setup({})";
		};
	};
}
