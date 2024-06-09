vim9script
syntax enable
colorscheme habamax
command! -nargs=1 G execute ':!git <args>'

for [var, val] in items({
	is_posix: 1, 
	mapleader: ';',
	netrw_banner: 0, 
	netrw_liststyle: 3
})
	execute 'g:' .. var .. ' = ' .. string(val)
endfor
  
for option in [
	'tabstop=2', 
	'cursorline',
	'noshowmode', 
	'noswapfile',
	'breakindent',
	'smartindent',
	'shiftwidth=2',
	'signcolumn=no',
	'scrolloff=999',
	'regexpengine=0',
	'relativenumber'
]
  execute 'set ' .. option
endfor

for [map, cmd] in items({
	lh: 'LspHover',
	lr: 'LspRename',
	ll: 'LspCodeLens',
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

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * {
  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)')) {
    PlugInstall | q
  }
}

call plug#begin()
	Plug 'mattn/vim-lsp-settings',
	Plug 'prabirshrestha/vim-lsp',
	Plug 'prabirshrestha/asyncomplete.vim',
	Plug 'prabirshrestha/asyncomplete-lsp.vim',
	Plug 'christoomey/vim-tmux-navigator'
call plug#end()
