return {
  colorscheme = "github_dark_default",
  lsp = {
    formatting = {
      format_on_save = true,
    },
  },
  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.colorscheme.github-nvim-theme"},
    { import = "astrocommunity.project.project-nvim" },
    { import = "astrocommunity.motion.nvim-spider" },
    { import = "astrocommunity.motion.hop-nvim" },
  },
}
