syntax on
let g:is_posix=1
colorscheme habamax
highlight Normal ctermbg=none

for option in [ 
  \ 'expandtab', 
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 'relativenumber', 
  \ 're=0',
  \ 'tabstop=2',
  \ 'shiftwidth=2',
\ ]
  execute 'set '.option
endfor
