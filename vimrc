syntax on
g:is_posix = 1
colorscheme habamax
highlight Normal ctermbg=none
highlight link netrwMarkFile Search

for option: string in [ 
  'incsearch',
  'noswapfile', 
  'cursorline',
  'relativenumber', 
  'expandtab', 
  'tabstop = 2',
  'shiftwidth = 2',
  're = 0'
]: string
  execute 'set '.option
endfor
