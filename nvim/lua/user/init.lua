return {
  colorscheme = "nord",
  lsp = {
    formatting = {
      format_on_save = true,
    },
  },
  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.colorscheme.nord-nvim"},
    { import = "astrocommunity.git.neogit" },
    { import = "astrocommunity.project.project-nvim" },
    { import = "astrocommunity.motion.nvim-spider" },
    { import = "astrocommunity.motion.hop-nvim" },
  },
}
