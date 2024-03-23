syntax on
let g:is_posix=1
colorscheme habamax
highlight Normal ctermbg=none

for option in [
  \ 're=0',
  \ 'expandtab', 
  \ 'tabstop=2',
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 'shiftwidth=2',
  \ 'relativenumber', 
\ ]
  execute 'set '.option
endfor
