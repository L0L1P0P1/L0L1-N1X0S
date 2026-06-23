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
        capabilities = ''
          capabilities.textDocument.diagnostic.dynamicRegistration = false
        '';
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
                return ("%s (%s) [%s]"):format(d.message, d.source, d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code) or "")
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
          gopls.enable = true;
          ruff.enable = true;

          postgres_lsp = {
            enable = true;
            package = pkgs.postgres-language-server;
          };

          basedpyright = {
            enable = true;
            package = pkgsUnstable.basedpyright;
            cmd = [
              "${pkgsUnstable.basedpyright}/bin/basedpyright-langserver"
              "--stdio"
            ];
            settings = {
              basedpyright.analysis = {
                autoImportCompletions = true;
                autoSearchPaths = true;
                diagnosticMode = "workspace";
                typeCheckingMode = "basic";
                diagnosticSeverityOverrides.reportUnusedExpression = "none";
              };
              python = {
                venvPath = ".";
                pythonPath = ".venv/bin/python";
              };
            };
          };

          nixd = {
            enable = true;
            package = pkgs.nixd;
            settings = {
              nixpkgs.expr = "import (builtins.getFlake \"path:/home/L0L1P0P/nixos\").inputs.nixpkgs { }";
              options = {
                home-manager.expr = "(builtins.getFlake \"path:/home/L0L1P0P/nixos\").nixosConfigurations.${hostname}.options.home-manager.users.type.getSubOptions []";
                nixos.expr = "(builtins.getFlake \"path:/home/L0L1P0P/nixos\").nixosConfigurations.${hostname}.options";
                nixvim.expr = "(builtins.getFlake \"path:/home/L0L1P0P/nixos\").inputs.nixvim.outputs.nixvimConfigurations.x86_64-linux.default.options";
              };
            };
          };

          clangd = {
            enable = true;
            package = null;
            cmd = [
              "clangd"
              # "--query-driver=/run/current-system/sw/bin/clang++,${pkgs.clang}/bin/clang++"
              "--function-arg-placeholders"
              "--completion-style=bundled"
              "--background-index"
              "--clang-tidy"
              "--header-insertion=iwyu"
              "--fallback-style=LLVM"
            ];
          };

          rust_analyzer = {
            enable = true;
            cmd = [ "rust-analyzer" ];
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
  };
}
