" Options
syntax on
set tabstop=2
set shiftwidth=2
set scrolloff=0
set mouse=a
set re=0

" Set Boolean Options to True
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
    \ 'nowrap',
    \ 'termguicolors',
    \ 'nocompatible',
\ ]
  execute 'set '.option
endfor

" Keys
let g:mapleader = ' '

"" General
nmap <leader>e :Explore<cr>

"" Pane Navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"" Fuzzy Finding
nmap <leader>ff :Files<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fw :Rg<cr>
nmap <leader>fm :Marks<cr>
nmap <leader>fc :Commands<cr>
nmap <leader>fk :Maps<cr>
nmap <leader>fC :Commits<cr>

" Plugins
"" Install Vim Plug If Not Found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"" Run :Pluginstall If There Are New Plugins   
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"" Plugin List
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
call plug#end()
