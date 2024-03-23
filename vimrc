syntax on
let g:is_posix=1
colorscheme habamax
highlight Normal ctermbg=none
highlight! link netrwMarkFile Search

for option in [ 
  \ 'incsearch',
  \ 'noswapfile', 
  \ 'cursorline',
  \ 'relativenumber', 
  \ 'expandtab', 
  \ 'tabstop=2',
  \ 'shiftwidth=2',
  \ 're=0',
\ ]
  execute 'set '.option
endfor
