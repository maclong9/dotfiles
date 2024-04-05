vim9script
g:is_posix = 1
syntax enable
filetype plugin on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
	'nowrap',
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

command! -nargs=1 G execute ':!git <args>'

augroup editor
	autocmd CursorMoved * normal! zz
augroup END

augroup templates
  autocmd BufNewFile *.sh :0r ~/.config/templates/skeleton.sh
augroup END
