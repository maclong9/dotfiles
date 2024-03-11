" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-latex/vim-latex'
call plug#end()

" Options
syntax on
let g:mapleader = " "

set tabstop=2
set shiftwidth=2
set background=dark
set scrolloff=0
set mouse=a
set nowrap

for option in [
    \ 'nocompatible',
    \ 'relativenumber',
    \ 'hlsearch',
    \ 'cindent',
    \ 'incsearch',
    \ 'ignorecase',
    \ 'smartcase',
    \ 'linebreak',
    \ 'expandtab',
\ ]
  execute 'set '.option
endfor

" Keymaps
nmap <leader>ff :Files<cr>
nmap <leader>ft :Colors<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fw :Rg<cr>
nmap <leader>fm :Marks<cr>
nmap <leader>fC :Commands<cr>
nmap <leader>fk :Maps<cr>
nmap <leader>fc :Commits<cr>
nmap <leader>fs :LspOutline<cr>
nmap <leader>la :LspCodeAction<cr>
nmap <leader>ld :LspDiag current<cr>
nmap <leader>lf :LspFormat<cr>
nmap <leader>lr :LspRename<cr>
nmap gd         :LspGotoDeclaration<cr>
nmap ]d         :LspDiag next<cr>
nmap [d         :LspDiag prev<cr>
