vim9script
syntax enable
g:is_posix = 1
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'cindent',
  'noswapfile',
  'noshowmode',
  'cursorline',
  'relativenumber',
]
  execute 'set ' .. option
endfor
