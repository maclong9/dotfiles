vim9script
g:is_posix = 1
syntax enable
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'tabstop=2',
  'noswapfile',
  'noshowmode',
  'cursorline',
  'smartindent',
  'shiftwidth=2',
  'relativenumber',
]
  execute 'set ' .. option
endfor
