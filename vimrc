" Install Vim Plug If Not Found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run :Pluginstall If There Are New Plugins   
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
  Plug 'tinted-theming/base16-vim'
call plug#end()

" Options
syntax on
set tabstop=2
set shiftwidth=2
set scrolloff=0
set mouse=a
set background=dark
colorscheme base16-oxocarbon-dark

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
\ ]
  execute 'set '.option
endfor

" Keys
let g:mapleader = ' '

"" Pane Navigation
nnoremap | :vsp<CR>
nnoremap \ :sp<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" Fuzzy Finding
nmap <leader>ff :Files<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fw :Rg<cr>
nmap <leader>fm :Marks<cr>
nmap <leader>fc :Commands<cr>
nmap <leader>fk :Maps<cr>
nmap <leader>fC :Commits<cr>

"" Emmet
function! SmartTab()
    if pumvisible() == 1
        return '\<C-n>'
    elseif &filetype == 'html' || &filetype == 'css' || &filetype == 'tsx'
        return '\<C-y>'
    else
        return '\<Tab>'
    endif
endfunction

inoremap <Tab> <C-R>=SmartTab()<CR>
