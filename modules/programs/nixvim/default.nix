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
    nixvim.molten-notebook = lib.mkOption {
      description = "enables molten and other plugins for jupyter notebook in nvim";
      type = lib.types.bool;
      default = true;
    };
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
    ./molten-notebook.nix
  ];

  config = lib.mkIf config.nixvim.enable {

    programs.nixvim = {
      enable = true;
      enableMan = true;

      nixpkgs.source = inputs.nixpkgs;

      # Color Schemes
      colorschemes.gruvbox-material-nvim = {
        enable = true;
        package = pkgsUnstable.vimPlugins.gruvbox-material-nvim;
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

        foldlevel = 99;
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
        neoscroll.enable = false;
        nix.enable = true;
        nvim-autopairs.enable = true;
        tmux-navigator.enable = true;
        vim-dadbod-completion.enable = true;
        vim-dadbod-ui.enable = true;
        vim-dadbod.enable = true;
        web-devicons.enable = true;
        fzf-lua.enable = true; # yes i added fzf-lua, no I am too lazy to configure it atm

        presence = {
          enable = false;
          package = pkgs.vimPlugins.presence-nvim;
        };

        noice = {
          enable = true;
          settings = {
            cmdline.view = "cmdline";
          };
        };

        oil = {
          enable = true;
          settings = {
            columns = [
              "permissions"
              "size"
              "mtime"
              "icon"
            ];
            keymaps = {
              "<C-l>" = false;
              "<C-h>" = false;
              "<C-s>" = false;
              "<C-r>" = "actions.refresh";
              "<leader>y." = "actions.copy_entry_path";
              "<leader>v" = {
                __unkeyed-1 = "actions.select";
                opts.vertical = true;
              };
              "<leader>x" = {
                __unkeyed-1 = "actions.select";
                opts.horizontal = true;
              };
              "<leader>ff" = {
                __unkeyed-1.__raw = ''
                  function()
                    require("fzf-lua").files({
                      cwd = require("oil").get_current_dir()
                    })
                  end
                '';
                desc = "Find files in the current directory";
              };
            };

            skip_confirm_for_simple_edits = true;
            view_options = {
              show_hidden = false;
            };
            win_options = {
              signcolumn = "yes:2";
            };
          };
        };

        oil-git-status = {
          enable = true;
          settings = {
            show_ignored = true;
          };
        };

        which-key = {
          enable = true;
          settings.delay = 400;
        };

        bufferline = {
          enable = true;
        };

        markview = {
          enable = true;
          settings = {
            preview = {
              hybrid_modes = [
                "n"
              ];
              icon_provider = "devicons";
            };
            latex = {
              enable = true;
              blocks = {
                enable = true;
                hl = "MarkviewPalette6Fg";
              };
              inlines = {
                enable = true;
                hl = "MarkviewPalette6Fg";
              };
            };
            markdown = {
              code_blocks = {
                enable = true;
                style = "block";
                min_width = 60;
              };
            };
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
          enable = false;
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

        treesitter = {
          enable = true;
          package = pkgs.vimPlugins.nvim-treesitter;
          settings.highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          indent.enable = true;
          folding.enable = true;
          nixGrammars = true;
          grammarPackages = config.programs.nixvim.plugins.treesitter.package.allGrammars;
        };

        luasnip = {
          enable = true;
          fromVscode = [
            { }
          ];
          filetypeExtend = {
            quarto = [ "markdown" ];
          };
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
