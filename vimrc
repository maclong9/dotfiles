vim9script
syntax enable
g:is_posix = 1
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'noswapfile',
  'noshowmode',
  'cursorline',
  'smartindent',
  'relativenumber',
]
  execute 'set ' .. option
endfor
