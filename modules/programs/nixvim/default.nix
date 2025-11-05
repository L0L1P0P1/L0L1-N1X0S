{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{

  options = {
    nixvim.enable = lib.mkEnableOption "enables nixvim";
  };

  imports = [
    ./keymaps.nix
    ./alpha.nix
    ./lsp.nix
  ];

  config = lib.mkIf config.nixvim.enable {

    programs.nixvim = {
      enable = true;
      enableMan = true;

      # Color Schemes
      colorschemes.gruvbox-material-nvim = {
        enable = true;
        settings = {
          italics = true;
          comments.italics = true;
        };
      };

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

      autoCmd = [
        {
          command = "set shiftwidth=2 tabstop=2";
          event = [
            "BufEnter"
            "BufWinEnter"
          ];
          pattern = [
            "*.c"
            "*.cpp"
            "*.h"
          ];
        }
      ];
      # Plugins
      plugins = {
        bufferline.enable = true;
        dressing.enable = true;
        gitsigns.enable = true;
        neogit.enable = true;
        neoscroll.enable = true;
        nix.enable = true;
        noice.enable = true;
        nvim-autopairs.enable = true;
        render-markdown.enable = true;
        tmux-navigator.enable = true;
        vim-dadbod-completion.enable = true;
        vim-dadbod-ui.enable = true;
        vim-dadbod.enable = true;
        web-devicons.enable = true;

        presence-nvim = {
          enable = true;
        };

        hardtime = {
          enable = false;
          settings.restriction_mode = "hint";
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
          ignoreFtOnSetup = [
            "dashboard"
            ""
          ];
          openOnSetup = true;
          settings = {
            filters.dotfiles = true;
            renderer.group_empty = true;
            update_focused_file = {
              enable = true;
              update_root = true;
            };
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
            fzf-native.enable = true;
          };
          keymaps = {
            "<C-q>" = {
              action = "send_selected_to_qflist";
              mode = [
                "i"
                "n"
              ];
            };
          };
          settings.defaults.mappings.i = {
            "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
            "<C-j>".__raw = "require('telescope.actions').move_selection_next";
          };
        };

        luasnip = {
          enable = true;
          fromVscode = [
            { }
          ];
        };
        friendly-snippets = {
          enable = true;
          package = pkgsUnstable.vimPlugins.friendly-snippets;
        };

        cmp-nvim-lsp.enable = true;
        cmp_luasnip.enable = true;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "vim-dadbod-completion"; }
              { name = "path"; }
              { name = "buffer"; }
              { name = "render-markdown"; }
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

        treesitter = {
          enable = true;
          settings = {
            auto_install = true;
            highlight.enable = true;
            indent = {
              enable = true;
            };
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
