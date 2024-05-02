vim9script
syntax enable
colorscheme habamax
highlight Normal ctermbg=none
autocmd CursorMoved * normal! zz
command! -nargs=1 G execute ':!git <args>'

for [var: string, val: number] in items({ 
	is_posix: 1, 
	netrw_banner: 0, 
	netrw_liststyle: 3 
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
	'signcolumn=no',
	'relativenumber',
	'regexpengine=0',
	'colorcolumn=80'
]
  execute 'set ' .. option
endfor

for [map: string, cmd: string] in items({
	lp: 'LspPreviousDiagnostic',
	ln: 'LspNextDiagnostic',
        lh: 'lsphover',
	lr: 'lsprename',
	ll: 'LspCodeLens',
	la: 'LspCodeAction',
	ld: 'LspDefinition',
	lt: 'LspTypeDefinition',
	ls: 'LspDocumentSymbol',
	lf: 'LspDocumentFormat'
})
	execute 'nmap <leader>' .. map .. ' :' .. cmd .. '<cr>'
endfor

call plug#begin()
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

