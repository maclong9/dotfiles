vim9script
syntax enable
g:is_posix = 1
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
