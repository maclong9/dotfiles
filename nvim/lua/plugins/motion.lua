return {
	{ -- WEB motions mork through camel case
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
		},
	},

	{ -- Quick jump to specifiod charactec
		"smoka7/hop.nvim",
		keys = {
			{ "<cr>", "<cmd>HopChar1<cr>", desc = "Hop to character" },
		},
		version = "*",
		opts = {},
	},
}
