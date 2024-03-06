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
			["<leader>b"] = false,
			["<leader>bb"] = false,
			["<leader>bd"] = false,
			["<leader>b\\"] = false,
			["<leader>b|"] = false,
			["<leader>ut"] = false,
		},
	},
	options = {
		o = {
			guifont = "Liga SFMono Nerd Font:h12",
			showtabline = 0,
		},
	},
	plugins = {
		"AstroNvim/astrocommunity",
		{ import = "astrocommunity.colorscheme.oxocarbon-nvim" },
		{ import = "astrocommunity.project.project-nvim" },
		{ import = "astrocommunity.motion.nvim-spider" },
		{ import = "astrocommunity.motion.hop-nvim" },
		{ import = "astrocommunity.motion.harpoon" },
		{ import = "astrocommunity.indent.indent-blankline-nvim" },
		{ import = "astrocommunity.indent.mini-indentscope" },
		{ import = "astrocommunity.pack.lua" },
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
		{ "rcarriga/nvim-notify",    enabled = false },
		{ "akinsho/toggleterm.nvim", enabled = false },
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = function(_, opts)
				opts.source_selector.sources = {
					{ source = "filesystem" },
				}
			end,
		},
		{
			"rebelot/heirline.nvim",
			opts = function(_, opts)
				local status = require("astronvim.utils.status")

				opts.tabline = nil

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
					status.component.fill(),
					status.component.numbercolumn(),
				}
			end,
		},
	},
}
