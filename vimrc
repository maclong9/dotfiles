vim9script
g:is_posix = 1
syntax enable
filetype plugin on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'path+=**',
  'tabstop=2',
  'noswapfile',
  'noshowmode',
  'cursorline',
  'smartindent',
  'breakindent',
  'shiftwidth=2',
  'relativenumber',
  'regexpengine=0',
]
  execute 'set ' .. option
endfor

command! -nargs=1 G execute ':!git <args>'

augroup editor
	autocmd CursorMoved * normal! zz
	autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx,*.py,*.c,*.sh,*.pl,*.rb,*.swift silent! !ctags -R .
augroup END

augroup templates
  autocmd BufNewFile *.sh :0r ~/.config/templates/skeleton.sh
augroup END
