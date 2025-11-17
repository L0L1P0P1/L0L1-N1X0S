{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  hostname,
  ...
}:
{
  programs.nixvim = {
    lsp = {
      luaConfig.pre = ''
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

        rust_analyzer = {
          enable = true;
          config = {
            installCargo = true;
            installRustc = true;
          };
        };

        clangd = {
          enable = true;
          package = pkgsUnstable.clang-tools;
          config.cmd = [
            "${pkgsUnstable.clang-tools}/bin/clangd"
            "--function-arg-placeholders"
            "--completion-style=bundled"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--fallback-style=mozilla"
          ];
        };

        basedpyright = {
          enable = true;
          package = pkgsUnstable.basedpyright;
          config = {
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
        };

        ruff = {
          enable = true;
        };

      };
    };

    plugins = {
      lsp-status.enable = true;
      lspkind.enable = true;
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;
        inlayHints = true;
        servers.nixd = {
          enable = true;
          package = pkgs.nixd;
          settings = {
            nixpkgs.expr = "import (builtins.getFlake \"git+file:///home/L0L1P0P/nixos\").inputs.nixpkgs { }";
            options = {
              home-manager.expr = "(builtins.getFlake \"git+file:///home/L0L1P0P/nixos\").nixosConfigurations.${hostname}.options.home-manager.users.type.getSubOptions []";
              nixos.expr = "(builtins.getFlake \"git+file:///home/L0L1P0P/nixos\").nixosConfigurations.${hostname}.options";
              nixvim.expr = "(builtins.getFlake \"git+file:///home/L0L1P0P/nixos\").inputs.nixvim.outputs.nixvimConfigurations.x86_64-linux.default.options";
            };
          };
        };
      };
    };
  };
}
