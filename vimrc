syntax on
colorscheme habamax
highlight Normal ctermbg=none

for option in [
  \ 'relativenumber', 
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 'expandtab', 
  \ 'tabstop=2',
  \ 'shiftwidth=2',
  \ 're=0',
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
