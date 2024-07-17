-- Neovim configuration

-- Install Lazy.nvim as the plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'kyazdani42/nvim-tree.lua',
  'nvim-lualine/lualine.nvim',
  'romgrk/barbar.nvim',
  'simrat39/symbols-outline.nvim',
  'folke/trouble.nvim',
  'akinsho/toggleterm.nvim',
}, {})

-- Set up nvim-tree (File Explorer)
require('nvim-tree').setup({
  view = {
    side = 'left',
    width = 30,
  },
})

-- Set up lualine (Status line)
require('lualine').setup()

-- Set up barbar (Buffers and Tabs)
require('barbar').setup()

-- Set up symbols-outline (Code Outline)
require('symbols-outline').setup({
  position = 'right',
})

-- Set up trouble (Problems/Diagnostics view)
require('trouble').setup({
  position = 'bottom',
  height = 10,
  width = 50,
})

-- Set up toggleterm (Terminal)
require('toggleterm').setup({
  direction = 'horizontal',
  size = 10,
})

-- Key mappings
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-s>', ':SymbolsOutlineToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':ToggleTerm<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', {silent = true, noremap = true})

-- Set up the layout
vim.cmd([[
  autocmd VimEnter * NvimTreeToggle
  autocmd VimEnter * wincmd l
  autocmd VimEnter * SymbolsOutlineOpen
  autocmd VimEnter * wincmd h
  autocmd VimEnter * TroubleToggle
  autocmd VimEnter * wincmd k
  autocmd VimEnter * ToggleTerm
]])

-- Neovide configuration
if vim.fn.exists('g:neovide') then
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_trail_length = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.1
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 7.0
end
