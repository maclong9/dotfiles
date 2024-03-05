return {
	colorscheme = "oxocarbon",
	heirline = {
		colors = {
			tabline_bg = "none",
		},
		separators = {
			breadcrumbs = " ",
		},
	},
	lsp = {
		formatting = {
			format_on_save = true,
		},
	},
	mappings = {
		n = {
			["<leader>fp"] = { "<cmd>Telescope projects<cr>" },
			["<leader>ln"] = { "<cmd>AerialNavToggle<cr>" },
		},
	},
	options = {
		o = {
			guifont = "Liga SFMono Nerd Font:h12",
		},
	},
	plugins = {
		"AstroNvim/astrocommunity",
		{ import = "astrocommunity.colorscheme.oxocarbon-nvim" },
		{ import = "astrocommunity.project.project-nvim" },
		{ import = "astrocommunity.motion.nvim-spider" },
		{ import = "astrocommunity.motion.hop-nvim" },
		{ import = "astrocommunity.pack.lua" },
		{ import = "astrocommunity.pack.svelte" },
		{ import = "astrocommunity.pack.tailwindcss" },
		{ import = "astrocommunity.pack.typescript-all-in-one" },
		{
			"goolord/alpha-nvim",
			opts = function(_, opts)
				opts.section.header.val = {
					"  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
					"   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
					"         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ",
					"          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
					"         ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
					"  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
					" ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
					"⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
					"⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
					"     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
					"      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
				}
			end,
		},
		{ "rcarriga/nvim-notify", enabled = false },
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = function(_, opts)
				local get_icon = require("astronvim.utils").get_icon

				opts.source_selector.sources = {
					{ source = "filesystem", display_name = get_icon("FolderClosed") .. " File" },
					{ source = "document_symbols", display_name = get_icon("FolderClosed") .. " Symbols" },
				}
			end,
		},
		{
			"rebelot/heirline.nvim",
			opts = function(_, opts)
				local status = require("astronvim.utils.status")

				opts.statusline = {
					status.component.mode(),
					status.component.git_branch(),
					status.component.git_diff(),
					status.component.diagnostics(),
					status.component.fill(),
					status.component.cmd_info(),
					status.component.fill(),
					status.component.nav({ percentage = false, scrollbar = false, ruler = {} }),
					status.component.mode({ surround = { separator = "right" } }),
				}

				opts.statuscolumn = {
					status.component.foldcolumn(),
					status.component.fill(),
					status.component.numbercolumn(),
				}
			end,
		},
	},
}
