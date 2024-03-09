return {
	colorscheme = "oxocarbon",
	heirline = {
		separators = {
			breadcrumbs = " ",
		},
	},
	diagnostics = {
		virtual_text = false,
	},
	lsp = {
		formatting = {
			format_on_save = true,
		},
	},
	mappings = {
		n = {
			["<leader>fp"] = { "<cmd>Telescope projects<cr>" },
		},
	},
	options = {
		opt = {
			showtabline = 0,
		},
	},
	plugins = {
		"AstroNvim/astrocommunity",
		{ import = "astrocommunity.colorscheme.oxocarbon-nvim" },
		{ import = "astrocommunity.editing-support.telescope-undo-nvim" },
		{ import = "astrocommunity.indent.indent-blankline-nvim" },
		{ import = "astrocommunity.indent.mini-indentscope" },
		{ import = "astrocommunity.motion.nvim-spider" },
		{ import = "astrocommunity.pack.ansible" },
		{ import = "astrocommunity.pack.docker" },
		{ import = "astrocommunity.pack.rust" },
		{ import = "astrocommunity.pack.tailwindcss" },
		{ import = "astrocommunity.pack.typescript-deno" },
		{ import = "astrocommunity.pack.zig" },
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
		{
			"rebelot/heirline.nvim",
			opts = function(_, opts)
				local status = require("astronvim.utils.status")

				opts = {
					tabline = nil,

					statusline = {
						status.component.mode(),
						status.component.git_branch(),
						status.component.git_diff(),
						status.component.diagnostics(),
						status.component.fill(),
						status.component.cmd_info(),
						status.component.fill(),
						status.component.nav({ percentage = false, scrollbar = false, ruler = {} }),
						status.component.mode({ surround = { separator = "right" } }),
					},

					statuscolumn = {
						status.component.fill(),
						status.component.numbercolumn(),
					},

					winbar = {
						status.component.breadcrumbs(),
					},
				}

				return opts
			end,
		},
		{
			import = "astrocommunity.file-explorer.oil-nvim",
			mappings = {
				["<leader>O"] = { "<cmd>Oil --float<cr>" },
			},
			opts = {
				deafult_file_explorer = true,
			},
		},
		{ "rcarriga/nvim-notify", enabled = false },
		{ "akinsho/toggleterm.nvim", enabled = false },
		{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	},
}
