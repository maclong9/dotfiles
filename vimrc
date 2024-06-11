vim9script
syntax enable
colorscheme habamax
command! -nargs=1 G execute ':!git <args>'

# TODO: Setup Quick Pane Switching
hi StatusLine ctermbg=36
hi StatusLineInactive ctermbg=234 ctermfg=36
hi VertSplit ctermbg=235 ctermfg=235
# TODO: Add Git Branch to StatusLine

for [var, val] in items({
	is_posix: 1, 
	mapleader: ';',
	netrw_banner: 0, 
	netrw_liststyle: 3,
})
	execute 'g:' .. var .. ' = ' .. string(val)
endfor
  
for option in [
	'cursorline',
	'noshowmode', 
	'noswapfile',
	'smartindent',
	'scrolloff=999',
	'regexpengine=0',
	'relativenumber',
        'fillchars+=vert:\ '
]
  execute 'set ' .. option
endfor

for [map, cmd] in items({
	lr: 'LspRename',
	la: 'LspCodeAction',
	ld: 'LspDefinition',
	lf: 'LspDocumentFormat',
	ls: 'LspDocumentSymbol',
	lt: 'LspTypeDefinition',
	ln: 'LspNextDiagnostic',
	lp: 'LspPreviousDiagnostic'
})
	execute 'nmap <leader>' .. map .. ' :' .. cmd .. '<cr>'
endfor

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'mattn/vim-lsp-settings',
	Plug 'prabirshrestha/vim-lsp',
	Plug 'prabirshrestha/asyncomplete.vim',
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()
