{ config, lib, ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "jk";
      action = "<ESC>";
      options = {
        desc = "Exit insert mode with jk";
      };
    }

    {
      mode = "n";
      key = "<leader>ww";
      action = ":w<CR>";
      options = {
        desc = "Write to the buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>wa";
      action = ":w<CR>";
      options = {
        desc = "Write to all buffers";
      };
    }

    {
      mode = "n";
      key = "<leader>qq";
      action = ":q<CR>";
      options = {
        desc = "Quit this buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>qa";
      action = ":qa<CR>";
      options = {
        desc = "Quit all buffers";
      };
    }

    {
      mode = "n";
      key = "<leader>nh";
      action = ":nohl<CR>";
      options = {
        desc = "Clear Search Highlights";
      };
    }

    {
      mode = "n";
      key = "<leader>sv";
      action = "<C-w>v";
      options = {
        desc = "Split window vertically";
      };
    }

    {
      mode = "n";
      key = "<leader>sh";
      action = "<C-w>s";
      options = {
        desc = "Split window horizontally";
      };
    }

    {
      mode = "n";
      key = "<leader>se";
      action = "<C-w>=";
      options = {
        desc = "Make Splits equal size";
      };
    }

    {
      mode = "n";
      key = "<leader>sx";
      action = "<cmd>close<CR>";
      options = {
        desc = "Close current split";
      };
    }

    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>tabnew<CR>";
      options = {
        desc = "Open new Tab";
      };
    }

    {
      mode = "n";
      key = "<leader>tx";
      action = "<cmd>tabclose<CR>";
      options = {
        desc = "Close current Tab";
      };
    }

    {
      mode = "n";
      key = "<leader>tn";
      action = "<cmd>tabn<CR>";
      options = {
        desc = "Go to next Tab";
      };
    }

    {
      mode = "n";
      key = "<leader>tp";
      action = "<cmd>tabp<CR>";
      options = {
        desc = "Go to previous Tab";
      };
    }

    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>tabnew %<CR>";
      options = {
        desc = "Open current buffer in new tab";
      };
    }

    {
      mode = "n";
      key = "gR";
      action = "<cmd>FzfLua lsp_references<CR>";
      options = {
        desc = "Show LSP reference";
      };
    }

    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      options = {
        desc = "Go to declaration";
      };
    }

    {
      mode = "n";
      key = "gd";
      action = "<cmd>FzfLua lsp_definitions<CR>";
      options = {
        desc = "Show LSP definition";
      };
    }

    {
      mode = "n";
      key = "gi";
      action = "<cmd>FzfLua lsp_implementations<CR>";
      options = {
        desc = "Show LSP implementations";
      };
    }

    {
      mode = "n";
      key = "gt";
      action = "<cmd>FzfLua lsp_typedefs<CR>";
      options = {
        desc = "Show LSP type definitions";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      options = {
        desc = "See available code actions";
      };
    }

    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      options = {
        desc = "Smart Rename";
      };
    }

    {
      mode = "n";
      key = "<leader>D";
      action = "<cmd>FzfLua diagnostics_document<CR>";
      options = {
        desc = "Show buffer diagnostics";
      };
    }

    {
      mode = "n";
      key = "<leader>d";
      action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      options = {
        desc = "Show line diagnostics";
      };
    }

    {
      mode = "n";
      key = "[d";
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      options = {
        desc = "Go to previous diagnostic";
      };
    }

    {
      mode = "n";
      key = "]d";
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      options = {
        desc = "Go to next diagnostic";
      };
    }

    {
      mode = "n";
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      options = {
        desc = "Show documentation for what is under cursor";
      };
    }

    {
      mode = "n";
      key = "<leader>rs";
      action = ":LspRestart<CR>";
      options = {
        desc = "Restart LSP";
      };
    }

    {
      mode = "n";
      key = "<leader>F";
      action = ":Format<CR>";
      options = {
        desc = "Format file";
      };
    }

    {
      mode = "n";
      key = "<leader>.";
      action = "<cmd>Oil .<CR>";
      options = {
        desc = "Open Current Working Directory";
      };
    }

    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>Oil<CR>";
      options = {
        desc = "Open Parent Directory of Current Buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>FzfLua files<CR>";
      options = {
        desc = "Fuzzy find files in current working directory";
      };
    }

    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>FzfLua live_grep<CR>";
      options = {
        desc = "Find string in current working directory";
      };
    }

    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>FzfLua oldfiles<CR>";
      options = {
        desc = "Fuzzy find recent files";
      };
    }

    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>FzfLua buffers<CR>";
      options = {
        desc = "Search Between Open Buffers";
      };
    }

    {
      mode = "n";
      key = "<leader>f/";
      action = "<cmd>FzfLua lgrep_curbuf<CR>";
      options = {
        desc = "Fuzzy Find in current buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>fq";
      action = "<cmd>FzfLua quickfix<CR>";
      options = {
        desc = "Find files in quickfix list";
      };
    }

    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>FzfLua git_commits<CR>";
      options = {
        desc = "Find Commits in Git Repository";
      };
    }

    {
      mode = "n";
      key = "<leader>fs";
      action = "<cmd>FzfLua git_status<CR>";
      options = {
        desc = "Interactive git status menu";
      };
    }

    {
      mode = "n";
      key = "<leader>fk";
      action = "<cmd>FzfLua keymaps<CR>";
      options = {
        desc = "List Keymaps";
      };
    }

    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>Neogit<CR>";
      options = {
        desc = "Open NeoGit Menu";
      };
    }

    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>NeogitCommit<CR>";
      options = {
        desc = "Open Last Commit";
      };
    }

    # {
    # 	mode = ;
    # 	key = ;
    # 	action = ;
    # 	options = {
    # 		desc = "";
    # 	};
    # }
  ];
}
