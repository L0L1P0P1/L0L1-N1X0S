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
        dressing.enable = true;
        gitsigns.enable = true;
        neogit.enable = true;
        neoscroll.enable = true;
        nix.enable = true;
        noice.enable = true;
        nvim-autopairs.enable = true;
        presence.enable = true;
        render-markdown.enable = true;
        tmux-navigator.enable = true;
        vim-dadbod-completion.enable = true;
        vim-dadbod-ui.enable = true;
        vim-dadbod.enable = true;
        web-devicons.enable = true;

        which-key = {
          enable = true;
          settings.delay = 400;
        };

        bufferline = {
          enable = true;
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

        lualine = {
          enable = true;
          package = pkgs.vimPlugins.lualine-nvim;
          settings = {
            options = {
              disabled_filetypes = [
                "NvimTree"
              ];
              ignore_focus = [ "NvimTree" ];
              section_separators = {
                left = "";
                right = "";
              };
            };
          };
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

        blink-cmp = {
          enable = true;
          settings = {
            keymap = {
              "<C-k>" = [
                "select_prev"
                "fallback"
              ];
              "<C-j>" = [
                "select_next"
                "fallback"
              ];
              "<Up>" = [
                "select_prev"
                "fallback"
              ];
              "<Down>" = [
                "select_next"
                "fallback"
              ];
              "<C-b>" = [
                "scroll_documentation_up"
                "scroll_signature_up"
                "fallback"
              ];
              "<C-f>" = [
                "scroll_documentation_down"
                "scroll_signature_down"
                "fallback"
              ];
              "<C-y>" = [
                "select_and_accept"
                "fallback"
              ];
              "<C-e>" = [
                "hide"
                "fallback"
              ];
              "<S-Tab>" = [
                "snippet_backward"
                "fallback"
              ];
              "<Tab>" = [
                "snippet_forward"
                "fallback"
              ];
              "<C-s>" = [
                "show_signature"
                "hide_signature"
                "fallback"
              ];
            };
            completion = {
              ghost_text.enabled = true;
              documentation = {
                auto_show = true;
              };
            };
            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
              ];
              per_filetype = {
                sql = [
                  "snippets"
                  "dadbod"
                ];
              };
              providers = {
                dadbod = {
                  name = "dadbod";
                  module = "vim_dadbod_completion.blink";
                };
              };
            };
            signature.enabled = true;
          };
        };
        # cmp-nvim-lsp.enable = true;
        # cmp_luasnip.enable = true;
        # cmp = {
        #   enable = true;
        #   autoEnableSources = true;
        #   settings = {
        #     sources = [
        #       { name = "nvim_lsp"; }
        #       { name = "luasnip"; }
        #       { name = "vim-dadbod-completion"; }
        #       { name = "path"; }
        #       { name = "render-markdown"; }
        #     ];
        #     mapping = {
        #       "<C-k>" = "cmp.mapping.select_prev_item()";
        #       "<C-j>" = "cmp.mapping.select_next_item()";
        #       "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        #       "<C-f>" = "cmp.mapping.scroll_docs(4)";
        #       "<C-space>" = "cmp.mapping.complete()";
        #       "<C-e>" = "cmp.mapping.abort()";
        #       "<CR>" = "cmp.mapping.confirm({ select = true })";
        #     };
        #   };
        # };
        # Extra Plugins
        # extraPlugins = [
        # 	pkgsUnstable.vimPlugins.cord-nvim
        # ];
        # extraConfigLua = "require('cord').setup({})";
      };
    };
  };
}
