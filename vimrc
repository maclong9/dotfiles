syntax on
let g:is_posix=1
colorscheme habamax
highlight Normal ctermbg=none

for option in [
  \ 'expandtab', 
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 're=0',
  \ 'tabstop=2',
  \ 'shiftwidth=2',
  \ 'relativenumber', 
\ ]
  execute 'set '.option
endfor
