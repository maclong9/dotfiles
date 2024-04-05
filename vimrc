vim9script
syntax enable
filetype plugin on
colorscheme habamax
highlight Normal ctermbg=none
command! -nargs=1 G execute ':!git <args>'                                       

var languages = {
  'typescript': ['ts', 'js', 'jsx', 'tsx'],
  'c': ['c', 'h'],
  'ruby': ['rb'],
  'python': ['py'],
  'shell': ['sh'],
  'perl': ['pl']
]

def ReadSnippet(type: string, name: string)
  let filename = 'snippets.' .. type
  execute 'read ' . fnameescape(filename) . ' | /^<!-- ' . name . ' -->/+1;/^<!--   End of ' . name . ' -->/-1 d | noh'
enddef

for [lang, exts] in items(languages)
  for ext in exts
    execute 'nnoremap <leader>' .. ext .. 'r :call ReadSnippet("' .. lang .. '",     expand("<cword>"))<CR>'
    execute 'nnoremap <leader>' .. ext .. 'R :call ReadSnippet("' .. lang .. '",     input("Snippet name: "))<CR>'
  endfor
endfor

for [var: string, val: number] in [
  ['is_posix', 1],
  ['netrw_banner', 0],
  ['netrw_liststyle', 3]
]
  execute 'g:' .. var .. ' = ' .. val
endfor
  
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

augroup editor
  autocmd CursorMoved * normal! zz
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
  autocmd BufNewFile * 
    var filetype = getbufvar('%', '&filetype')
    for [lang, exts] in items(languages)
      if index(exts, filetype) != -1
        execute ':0r ~/.config/templates/skeleton.' .. exts[0]
        break
      endif
    endfor
  }
augroup END
