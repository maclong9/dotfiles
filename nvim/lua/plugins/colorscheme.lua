return {
  { "lunacookies/vim-colors-xcode" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "xcodedark",
    },
    init = function()
      vim.opt.termguicolors = false
      vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
      vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
      vim.cmd("hi StatusLine guibg=NONE guifg=#666666 ctermbg=NONE ctermfg=244")
      vim.cmd("hi LineNr guifg=#666666 ctermfg=244")
      vim.cmd("hi Comment guifg=#666666 ctermfg=244")
    end,
  },
}
