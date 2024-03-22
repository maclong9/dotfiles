colorscheme xcode
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
  \ 'autoread',
  \ 'ttimeout',
  \ 'wildmenu',
  \ 'ttimeoutlen=100',
  \ 'scrolloff=0', 
  \ 'mouse=a', 
  \ 're=0',
  \ 'background=dark',
  \ 'conceallevel=1',
\ ]
  execute 'set '.option
endfor

for var in [
  \ 'g:is_posix=1',
  \ 'g:mapleader=";"',
  \ 'g:tex_conceal='abdmg',
\ ]
  execute 'let '.var
endfor

for mapping in [
  \ ['e',  'Explore'],
  \ ['ez', 'edit ~/.config/zshrc'],
  \ ['ev', 'edit ~/.config/vimrc'],
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
    \ 'tpope/vim-rsi',
    \ 'arzg/vim-colors-xcode'
  \ ]
    Plug plugin
  endfor
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
