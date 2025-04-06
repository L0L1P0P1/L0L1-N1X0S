{config, lib, ...}:
{
	programs.nixvim.plugins.alpha.enable = true;
	programs.nixvim.plugins.alpha.layout = [
		{
			type = "padding";
			val = 8;
		}
		{
			type = "text";
			val = [
				 "                                                     "
				 "  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ "
				 "  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ "
				 " ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ "
				 " ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  "
				 " ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ "
				 " ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ "
				 " ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ "
				 "    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    "
				 "          ░    ░  ░    ░ ░        ░   ░         ░    "
				 "                                 ░                   "
				 "                                                     "
			];
			opts = {
				position = "center";
				hl = "Type";
			};
		}
		{
			type = "padding";
			val = 2;
		}
		{
			type = "group";
			val = [
				# New File
				{
					type = "button";
					val = "     New File    ";
					on_press.__raw = "function() vim.cmd[[ene]] end";
					opts = {
						shortcut = "n";
						keymap = [
							"n"
							"n"
							"<cmd>ene<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 1;
				}

				# Telescope Find Files
				{
					type = "button";
					val = "     Find File    ";
					opts = {
						shortcut = "f";
						keymap = [
							"n"
							"f"
							"<cmd>Telescope find_files<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 1;
				}
				
				# Telescope Recent Files
				{
					type = "button";
					val = "     Recent Files    ";
					on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
					opts = {
						shortcut = "r";
						keymap = [
							"n"
							"r"
							"<cmd>Telescope oldfiles<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 1;
				}

				# Telescope live grep 
				{
					type = "button";
					val = "     Find Text    ";
					opts = {
						shortcut = "g";
						keymap = [
							"n"
							"g"
							"<cmd>Telescope live_grep<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 1;
				}

				# Open DBUI 
				{
					type = "button";
					val = "     Open DadBod-UI    ";
					opts = {
						shortcut = "d";
						keymap = [
							"n"
							"d"
							"<cmd>ene | DBUI<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 1;
				}

				# Quit Nvim
				{
					type = "button";
					val = "     Quit Neovim    ";
					on_press.__raw = "function() vim.cmd[[qa]] end";
					opts = {
						shortcut = "q";
						keymap = [
							"n"
							"q"
							"<cmd>qa<CR>"
							{
								noremap = true;
								silent = true;
								nowait = true;
							}
						];
						position = "center";
						width = 35;
						align_shortcut = "right";
						hl_shortcut = "Keyword";
					};
				}
				{
					type = "padding";
					val = 3;
				}

				{
					opts = {
						hl = "Keyword";
						position = "center";
					};
					type = "text";
					val = "\"The Only Good is Knowledge";
				}
				{
					opts = {
						hl = "Keyword";
						position = "center";
					};
					type = "text";
					val = "and The Only Evil is Ignorance\"";
				}
				{
					opts = {
						hl = "Keyword";
						position = "center";
					};
					type = "text";
					val = "- Socrates";
				}
			];
		}
	];
}
