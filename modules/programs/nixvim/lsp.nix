{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp-status.enable = true;
    lspkind.enable = true;
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };

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
        lua_ls.enable = true;
        nixd.enable = true;

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

        basedpyright = {
          enable = true;
          package = pkgsUnstable.basedpyright;
          cmd = [
            "${pkgsUnstable.basedpyright}/bin/basedpyright-langserver"
            "--stdio"
            "--pythonpath"
            "$(eval \"which python\")"
          ];
          settings = {
            basedpyright.analysis = {
              autoImportCompletions = true;
              autoSearchPaths = true;
              diagnosticMode = "workspace";
              typeCheckingMode = "basic";
            };
          };
        };

        ruff = {
          enable = true;
        };

      };
    };
  };
}
