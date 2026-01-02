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
    nixvim.obsidianWorkspaces = lib.mkOption {
      description = "Obsidian Workspaces for obsidian.nvim";
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [ ];
    };
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
            "*.md"
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

        markview = {
          enable = true;
          settings.preview = {
            hybrid_modes = [
              "n"
            ];
          };
        };

        obsidian = {
          enable = true;
          package = pkgsUnstable.vimPlugins.obsidian-nvim;
          settings = {
            "legacy_commands" = false;
            frontmatter.enabled = false;
            new_notes_location = "current_dir";
            completion = {
              blink-cmp = true;
            };
            templates.folder = "Templates";
            workspaces = config.nixvim.obsidianWorkspaces;
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
          highlight.enable = true;
          indent.enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            json
            javascript
            python
            cpp
            c
            rust
            lua
            nix
            sql
            vim
            regex
            bash
            markdown
            markdown_inline
          ];
        };

        luasnip = {
          enable = true;
          fromVscode = [
            { }
          ];
          settings.enable_autosnippets = true;
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
            snippets = {
              preset = "luasnip";
            };
            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "dadbod"
                "obsidian"
                "obsidian_tags"
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
      };

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "luasnip-latex-snippets";
          src = pkgs.fetchFromGitHub {
            owner = "iurimateus";
            repo = "luasnip-latex-snippets.nvim";
            rev = "57e4330f967da6ac64bf9b05b06ecb3c4a120ec3";
            hash = "sha256-JziRu7Ff0SaF6o/Ubfpx1FWb+k/Qywckp9oI9wUsvfA=";
          };
          doCheck = false;
        })
      ];

      extraConfigLuaPost = ''
        require("luasnip-latex-snippets").setup({
          use_treesitter = true,
          allow_on_markdown = true,
        })
      '';

    };
  };
}
