-- Install lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call to prevent errors on startup
local ok, lazy = pcall(require, "lazy")
if not ok then
  return
end

lazy.setup({
  -- Add plugins
  {
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    dependencies = {
      "williamboman/mason.nvim", -- Simple to use language server installer
      "williamboman/mason-lspconfig.nvim", -- Bridges gap between mason.nvim and nvim-lspconfig
    },
  },
  "nvim-treesitter/nvim-treesitter", -- Syntax highlighting
  "nvim-treesitter/nvim-treesitter-context", -- Show context at the top
  "windwp/nvim-ts-autotag", -- Auto-close and auto-rename HTML tags
  "nvim-treesitter/playground", -- Interactive playground
  "nvim-telescope/telescope.nvim", -- Fuzzy finder
  "datsfilipe/vesper.nvim", -- Vesper theme
  "nvim-lualine/lualine.nvim", -- Statusline
  "lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
  "numToStr/Comment.nvim", -- Easily comment stuff
  "lewis6991/gitsigns.nvim", -- Git integration
  "kyazdani42/nvim-web-devicons", -- File icons
  "akinsho/toggleterm.nvim", -- Terminal integration
  "ahmedkhalf/project.nvim", -- Project management
  "windwp/nvim-autopairs", -- Autopairs
  "hrsh7th/nvim-cmp", -- Autocompletion
  "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "L3MON4D3/LuaSnip", -- Snippets plugin
  "rafamadriz/friendly-snippets", -- Snippets collection
  "jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  "nvim-telescope/telescope-file-browser.nvim", -- File browser extension for telescope.nvim
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  "alvan/vim-closetag", -- Auto-close (X)HTML tags
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  },
  {
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter" }, -- or require if not used so far
    after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
  },
  "windwp/nvim-autopairs",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  "ziglang/zig.vim",
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  "stevearc/dressing.nvim",
  "lewis6991/gitsigns.nvim",
  "windwp/nvim-ts-autotag",
  "NvChad/nvim-colorizer.lua",
  "tpope/vim-abolish",
  "styled-components/vim-styled-components",
  "pangloss/vim-javascript",
  "javascript-libraries-syntax.vim",
  { "akinsho/bufferline.nvim", tag = "v3.*" },
  "navarasu/onedark.nvim",
  "kyazdani42/nvim-tree.lua",
  "ful1e5/lsp_lines.nvim",
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  "glepnir/lspsaga.nvim",
  "folke/which-key.nvim",
  "lukas-reineke/indent-blankline.nvim",
  { "akinsho/nvim-bufferline.lua", tag = "v3.*" },
  "gelguy/tailwindcss-nvim",
})

-- Setup LSP servers
local lspconfig = require("lspconfig")
local mason = require("mason")
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable LSP servers
mason.setup_handlers({
  function(server)
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})

-- Set up TypeScript, CSS, and HTML servers
lspconfig.tsserver.setup({})
lspconfig.cssls.setup({})
lspconfig.html.setup({})

-- Set up null-ls (formatter, linter, etc.)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint,
  },
})

-- Enable Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "css", "html" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Enable Tailwind CSS plugin
require("tailwindcss-nvim").setup()

-- Enable Vesper theme
vim.cmd("colorscheme vesper")
