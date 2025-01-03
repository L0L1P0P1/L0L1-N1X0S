{config, lib, ...}:
{
	programs.nixvim.keymaps = [
		{
			mode = "i";
			key = "jk";
			action = "<ESC>" ;
			options = {
				desc = "Exit insert mode with jk";
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
			key = "<leader>ee";
			action = "<cmd>NvimTreeToggle<CR>";
			options = {
				desc = "Toggle file explorer";
			};
		}

		{
			mode = "n" ;
			key = "<leader>ef";
			action = "<cmd>NvimTreeFindFileToggle<CR>";
			options = {
				desc = "Toggle file explorer on current file";
			};
		}

		{
			mode = "n";
			key = "<leader>ec";
			action = "<cmd>NvimTreeCollapse<CR>";
			options = {
				desc = "Collapse file explorer";
			};
		}

		{
			mode = "n";
			key = "<leader>er";
			action = "<cmd>NvimTreeRefresh<CR>";
			options = {
				desc = "Refresh file explorer";
			};
		}

		{
			mode = "n";
			key = "gR";
			action = "<cmd>Telescope lsp_references<CR>";
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
			action = "<cmd>Telescope lsp_definitions<CR>";
			options = {
				desc = "Show LSP definition";
			};
		}

		{
			mode = "n";
			key = "gi";
			action = "<cmd>Telescope lsp_implementations<CR>";
			options = {
				desc = "Show LSP implementations";
			};
		}

		{
			mode = "n";
			key = "gt";
			action = "<cmd>Telescope lsp_type_definitions<CR>";
			options = {
				desc = "Show LSP definitions";
			};
		}

		{
			mode = ["n" "v"];
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
			action = "<cmd>Telescope diagnostics bufnr=0<CR>";
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
			key = "<leader>ff";
			action = "<cmd>Telescope find_files<CR>";
			options = {
				desc = "Fuzzy find files in current working directory";
			};
		}

		{
			mode = "n";
			key = "<leader>fg";
			action = "<cmd>Telescope live_grep<CR>";
			options = {
				desc = "Find string in current working directory";
			};
		}

		{
			mode = "n";
			key = "<leader>fr";
			action = "<cmd>Telescope oldfiles<CR>";
			options = {
				desc = "Fuzzy find recent files";
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
