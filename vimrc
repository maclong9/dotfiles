for option in [
  \ 'nocompatible', 
  \ 'relativenumber', 
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 'expandtab', 
  \ 'tabstop=2',
  \ 'shiftwidth=2',
  \ 're=0',
  \ 'completeopt+=menuone',
  \ 'shortmess+=c',
\ ]
  execute 'set '.option
endfor

for var in [
  \ 'is_posix=1',
  \ 'mapleader=";"',
  \ 'netrw_banner=0',
\ ]
  execute 'let g:'.var
endfor

for mapping in [
  \ ['ee', 'Explore'],
  \ ['ez', 'edit ~/.config/zshrc'],
  \ ['ev', 'edit ~/.config/vimrc'],
  \ ['ff', 'Files'],
  \ ['fb', 'Buffers'],
  \ ['fw', 'Rg'],
  \ ['fm', 'Marks'],
  \ ['fC', 'Commits'],
\ ]
    execute 'nmap <leader>'.mapping[0].' :'.mapping[1].'<CR>'
endfor

call plug#begin()
  for plugin in [
    \ 'junegunn/fzf.vim',
    \ 'sheerun/vim-polyglot',
    \ 'mattn/emmet-vim',
    \ 'tpope/vim-fugitive',
    \ 'tpope/vim-rsi',
    \ 'lifepillar/vim-mucomplete',
  \ ]
    Plug plugin
  endfor
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

syntax on
colorscheme habamax
highlight Normal ctermbg=none
