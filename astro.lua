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
			["<leader>ff"] = { "<cmd>Telescope projects<cr>" },
			["<leader>ln"] = { "<cmd>AerialNavToggle<cr>" },
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
		{ 
			import = "astrocommunity.colorscheme.oxocarbon-nvim",
			opts = function()
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			end
		},
		{ import = "astrocommunity.editing-support.yanky-nvim" },
		{ import = "astrocommunity.editing-support.telescope-undo-nvim" },
		{ import = "astrocommunity.indent.indent-blankline-nvim" },
		{ import = "astrocommunity.indent.mini-indentscope" },
		{ import = "astrocommunity.motion.hop-nvim" },
		{ import = "astrocommunity.motion.nvim-spider" },
		{ import = "astrocommunity.pack.lua" },
		{ import = "astrocommunity.pack.svelte" },
		{ import = "astrocommunity.pack.tailwindcss" },
		{ import = "astrocommunity.pack.typescript-all-in-one" },
		{ import = "astrocommunity.project.project-nvim" },
		{ import = "astrocommunity.scrolling.cinnamon-nvim" },
		{ import = "astrocommunity.scrolling.satellite" },
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
		{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
		{
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
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

				return opts
			end,
		},
	},
}
