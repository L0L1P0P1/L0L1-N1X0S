{ config, lib, pkgs, pkgsUnstable, ...}:
{
	programs.nixvim.plugins = {
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
	};
}
