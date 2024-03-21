colorscheme habamax
highlight Normal ctermbg=none
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
  \ 'noswapfile', 
  \ 'tabstop=2', 
  \ 'shiftwidth=2',
  \ 'scrolloff=0', 
  \ 'mouse=a', 
  \ 're=0'
\ ]
  execute 'set '.option
endfor

let g:mapleader = ' '
for mapping in [
  \ ['e', 'Explore'],
  \ ['ff', 'Files'],
  \ ['fb', 'Buffers'],
  \ ['fw', 'Rg'],
  \ ['fm', 'Marks'],
  \ ['fc', 'Commands'],
  \ ['fk', 'Maps'],
  \ ['fC', 'Commits'],
  \ ['sv', 'vsp'], 
  \ ['sh', 'sp'],
\ ]
  if len(mapping[0]) <= 2
    execute 'nmap <leader>'.mapping[0].' :'.mapping[1].'<CR>'
  else
    execute 'nmap '.mapping[0].' :'.mapping[1]
  endif
endfor

call plug#begin()
  for plugin in [
    \ 'junegunn/fzf.vim',
    \ 'sheerun/vim-polyglot',
    \ 'mattn/emmet-vim',
    \ 'tpope/vim-fugitive',
    \ 'tpope/vim-surround',
  \ ]
    Plug plugin
  endfor
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
