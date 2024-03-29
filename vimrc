vim9script
g:is_posix = 1
syntax enable
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

def command! G(args: string)
  execute ':!git ' .. args
enddef

augroup templates
  autocmd BufNewFile *.sh 0r ~/.config/templates/skeleton.sh
augroup END
