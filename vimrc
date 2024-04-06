vim9script
syntax enable
filetype plugin on
colorscheme habamax
highlight Normal ctermbg=none
command! -nargs=1 G execute ':!git <args>'

var languages: dict<list<string>> = {
  'c': ['c', 'h'],
  'shell': ['sh'],
  'perl': ['pl'],
  'python': ['py'],
  'json': ['json'],
  'typescript': ['tsx', 'js', 'ts'],
}

for [var: string, val: number] in items({ 
  'is_posix': 1, 
  'netrw_banner': 0, 
  'netrw_liststyle': 3 
})
    execute 'g:' .. var .. ' = ' .. val
endfor

  
for option: string in [
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

def AutoSave(message: string)
	if &modified
		silent! write
		echo message
	endif
enddef

augroup editor
  autocmd CursorMoved * normal! zz
	autocmd CursorHold * AutoSave("File saved.")
  autocmd BufWritePost * {
    var filetype = getbufvar('%', '&filetype')                                   
    for [lang, exts] in items(languages)
      if index(exts, filetype) != -1
        silent! execute '!ctags -R .'
        break
      endif
    endfor
  }
augroup END

augroup templates
  autocmd BufNewFile * {
    var filetype = getbufvar('%', '&filetype')
    for [lang, exts] in items(languages)
      if index(exts, filetype) != -1
        execute ':0r ~/.config/templates/skeleton.' .. exts[0]
        break
      endif
    endfor
  }
augroup END
