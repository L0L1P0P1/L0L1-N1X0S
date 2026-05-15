{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  config = lib.mkIf config.nixvim.molten-notebook {
    programs.nixvim = {
      autoCmd = [
        {
          command = "QuartoActivate";
          event = [
            "FileType"
          ];
          pattern = [
            "markdown"
          ];
        }
        {
          event = [ "BufAdd" ];
          pattern = [ "*.ipynb" ];
          command = "MoltenImportOutput";
        }
        {
          event = [ "BufEnter" ];
          pattern = [ "*.ipynb" ];
          callback.__raw = ''
            function()
              if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
                vim.cmd("MoltenImportOutput")
              end
            end
          '';
        }
        {
          event = [ "BufWritePost" ];
          pattern = [ "*.ipynb" ];
          callback.__raw = ''
            function()
              if require("molten.status").initialized() == "Molten" then
                vim.cmd("MoltenExportOutput!")
              end
            end
          '';
        }
      ];

      plugins = {
        otter.enable = true;
        image = {
          enable = true;
          settings = {
            backend = "kitty";
            max_height = 12;
            max_height_window_percentage = {
              __raw = "math.huge";
            };
            max_width = 250;
            max_width_window_percentage = {
              __raw = "math.huge";
            };
            window_overlap_clear_enabled = true;
            window_overlap_clear_ft_ignore = [
              "cmp_menu"
              "cmp_docs"
              ""
            ];
          };
        };
        quarto = {
          enable = true;
          settings = {
            codeRunner = {
              enabled = true;
              default_method = "molten";
            };
          };
        };
        jupytext = {
          enable = true;
          settings = {
            style = "markdown";
            output_extension = "md";
            force_ft = "markdown";
          };
        };
        molten = {
          enable = true;
          package = pkgsUnstable.vimPlugins.molten-nvim;
          python3Dependencies =
            p: with p; [
              pynvim
              jupyter-client
              cairosvg
              ipython
              nbformat
              ipykernel
              pnglatex
              plotly
              kaleido
              pyperclip
            ];

          settings = {
            enter_output_behavior = "open_and_enter";
            image_provider = "image.nvim";
            image_location = "float";
            auto_open_output = false;
            cover_empty_lines = false;
            output_win_style = false;
            output_virt_lines = false;
            output_win_hide_on_leave = false;
            output_win_cover_gutter = true;
            output_crop_border = true;
            output_show_more = true;
            output_win_border = [
              ""
              "━"
              ""
              ""
            ];
            save_path = {
              __raw = "vim.fn.stdpath('data')..'/molten'";
            };
            show_mimetype_debug = true;
            tick_rate = 200;
            use_border_highlights = true;
            virt_lines_off_by_1 = true;
            virt_text_output = true;
            virt_text_max_lines = 20;
            wrap_output = true;
            win_hide_on_leave = true;
          };
        };

        treesitter = {
          luaConfig.pre = ''
            vim.treesitter.query.set("markdown", "textobjects", [[
              (fenced_code_block
                (code_fence_content) @code_cell.inner) @code_cell.outer
            ]])
          '';
        };

        treesitter-textobjects = {
          enable = true;
          settings = {
            move = {
              enable = true;
              set_jumps = false;

              goto_next_start = {
                "]c" = {
                  query = "@code_cell.inner";
                  desc = "next code cell";
                };
              };

              goto_previous_start = {
                "[c" = {
                  query = "@code_cell.inner";
                  desc = "previous code cell";
                };
              };
            };

            select = {
              enable = true;
              lookahead = true;

              keymaps = {
                ic = {
                  query = "@code_cell.inner";
                  desc = "in cell";
                };

                ac = {
                  query = "@code_cell.outer";
                  desc = "around cell";
                };
              };
            };

            swap = {
              enable = true;
              swap_next = {
                "<leader>scl" = "@code_cell.outer";
              };
              swap_previous = {
                "<leader>sch" = "@code_cell.outer";
              };
            };
          };
        };
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>rc";
          action = "<cmd>lua require('quarto.runner').run_cell()<CR>";
          options = {
            desc = "run cell";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>ra";
          action = "<cmd>lua require('quarto.runner').run_above()<CR>";
          options = {
            desc = "run cell and above";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>rA";
          action = "<cmd>lua require('quarto.runner').run_all()<CR>";
          options = {
            desc = "run all cells";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>rl";
          action = "<cmd>lua require('quarto.runner').run_line()<CR>";
          options = {
            desc = "run line";
            silent = true;
          };
        }

        {
          mode = "v";
          key = "<leader>r";
          action = "<cmd>lua require('quarto.runner').run_range()<CR>";
          options = {
            desc = "run visual range";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>RA";
          action = "<cmd>lua require('quarto.runner').run_all(true)<CR>";
          options = {
            desc = "run all cells of all languages";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>os";
          action = ":noautocmd MoltenEnterOutput<CR>";
          options = {
            desc = "open output window";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>oh";
          action = ":MoltenHideOutput<CR>";
          options = {
            desc = "close output window";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>md";
          action = ":MoltenDelete<CR>";
          options = {
            desc = "delete Molten cell";
            silent = true;
          };
        }

        {
          mode = "n";
          key = "<leader>rr";
          action = ":MoltenReevaluateCell<CR>";
          options = {
            desc = "re-eval cell";
            silent = true;
          };
        }
      ];

      extraLuaConfig = ''
        local default_notebook = [[
          {
            "cells": [
              {
                "cell_type": "markdown",
                "metadata": {},
                "source": [""]
              }
            ],
            "metadata": {
              "kernelspec": {
                "display_name": "Python 3",
                "language": "python",
                "name": "python3"
              },
              "language_info": {
                "codemirror_mode": {
                  "name": "ipython"
                },
                "file_extension": ".py",
                "mimetype": "text/x-python",
                "name": "python",
                "nbconvert_exporter": "python",
                "pygments_lexer": "ipython3"
              }
            },
            "nbformat": 4,
            "nbformat_minor": 5
          }
          ]]

          local function new_notebook(filename)
            local path = filename .. ".ipynb"
            local file = io.open(path, "w")

            if not file then
              vim.notify("Could not create notebook file", vim.log.levels.ERROR)
              return
            end

            file:write(default_notebook)
            file:close()

            vim.cmd("edit " .. vim.fn.fnameescape(path))
          end

          vim.api.nvim_create_user_command("NewNotebook", function(opts)
            new_notebook(opts.args)
          end, {
            nargs = 1,
            complete = "file",
          })
      '';
    };
  };
}
