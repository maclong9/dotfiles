vim9script
g:is_posix = 1
syntax on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'incsearch',
  'noshowmode',
  'cursorline',
  'relativenumber',
  'expandtab',
  'cindent',
  'tabstop=2',
  'shiftwidth=2',
  're=0'
]
  execute 'set ' .. option
endfor
