vim9script
g:is_posix = 1
syntax on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'number',
  'relativenumber',
  'noswapfile',
  'smartindent',
  'noshowmode',
  'cursorline',
  'incsearch',
  'expandtab',
  'tabstop=2',
  'shiftwidth=2',
]
  execute 'set ' .. option
endfor
