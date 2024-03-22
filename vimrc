let g:is_posix=1
let g:mapleader=";"
let g:netrw_banner=0

set nocompatible
set relativenumber
set incsearch
set expandtab
set noswapfile
set cursorline
set re=0
set completeopt+=menuone
set shortmess+=c
set tabstop=2
set shiftwidth=2

nnoremap <leader>ee :Explore<CR>
nnoremap <leader>ez :edit ~/.config/zshrc<CR>
nnoremap <leader>ev :edit ~/.config/vimrc<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fw :Rg<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fC :Commits<CR>

call plug#begin()
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'lifepillar/vim-mucomplete'
call plug#end()

syntax on
colorscheme habamax
highlight Normal ctermbg=none
