vim9script
g:is_posix = 1
syntax on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'relativenumber',
  'noswapfile',
  'cindent',
  'noshowmode',
  'cursorline',
  'incsearch',
]
  execute 'set ' .. option
endfor
