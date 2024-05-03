vim9script
syntax enable
colorscheme habamax
highlight Normal ctermbg=none
autocmd CursorMoved * normal! zz
command! -nargs=1 G execute ':!git <args>'

for [var, val] in items({
	is_posix: 1, 
	netrw_banner: 0, 
	netrw_liststyle: 3,
	mapleader: ';'
})
	execute 'g:' .. var .. ' = ' .. string(val)
endfor
  
for option in [
	'tabstop=2', 
	'noswapfile',
	'noshowmode', 
	'cursorline',
	'smartindent',
	'breakindent',
	'shiftwidth=2',
	'signcolumn=no',
	'relativenumber',
	'regexpengine=0',
	'colorcolumn=80'
]
  execute 'set ' .. option
endfor

for [map, cmd] in items({
	db: '!lldb<cr>',
	la: 'LspCodeAction',
	ld: 'LspDefinition',
	lf: 'LspDocumentFormat',
	lg: 'LspDefinition',
	lh: 'LspHover',
	ll: 'LspCodeLens',
	ln: 'LspNextDiagnostic',
	lp: 'LspPreviousDiagnostic',
	lr: 'LspRename',
	ls: 'LspDocumentSymbol',
	lt: 'LspTypeDefinition',
})
	execute 'nmap <leader>' .. map .. ' :' .. cmd .. '<cr>'
endfor

call plug#begin()
	Plug 'prabirshrestha/vim-lsp',
	Plug 'mattn/vim-lsp-settings',
	Plug 'prabirshrestha/asyncomplete.vim',
	Plug 'prabirshrestha/asyncomplete-lsp.vim',
call plug#end()

