" Options
syntax on
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
  \ 'termguicolors', 
  \ 'tabstop=2', 
  \ 'shiftwidth=2',
  \ 'scrolloff=0', 
  \ 'mouse=a', 
  \ 're=0'
\ ]
  execute 'set '.option
endfor

" Keys
let g:mapleader = ' '
for mapping in [
      \ ['e', 'Explore'],
      \ ['sv', 'vsp'],
      \ ['sh', 'sp'],
      \ ['<C-h>', '<C-w>h'],
      \ ['<C-j>', '<C-w>j'],
      \ ['<C-k>', '<C-w>k'],
      \ ['<C-l>', '<C-w>l'],
      \ ['ff', 'Files'],
      \ ['fb', 'Buffers'],
      \ ['fw', 'Rg'],
      \ ['fm', 'Marks'],
      \ ['fc', 'Commands'],
      \ ['fk', 'Maps'],
      \ ['fC', 'Commits']
\ ]
  if len(mapping[0]) <= 2
    execute 'nmap <leader>'.mapping[0].' :'.mapping[1].'<CR>'
  else
    execute 'nmap '.mapping[0].' :'.mapping[1]
  endif
endfor


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
