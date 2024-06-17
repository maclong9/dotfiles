vim9script
syntax enable
colorscheme habamax
command! -nargs=1 G execute ':!git <args>'

for [var, val] in items({
    is_posix: 1, 
    mapleader: ';',
    netrw_banner: 0, 
    netrw_liststyle: 3,
})
    execute 'g:' .. var .. ' = ' .. string(val)
endfor

for [group, attrs] in items({
    'StatusLine': { 'ctermbg': 36 },
    'StatusLineNC': { 'ctermbg': 235, 'ctermfg': 36 },
    'VertSplit': { 'ctermbg': 235, 'ctermfg': 235 }
})
    for [attr, val] in items(attrs)
        execute 'hi ' .. group .. ' ' .. attr .. '=' .. string(val)
    endfor
endfor
  
for option in [
    'tabstop=4',
    'cursorline',
    'noshowmode', 
    'noswapfile',
    'breakindent',
    'smartindent',
    'shiftwidth=4',
    'signcolumn=no',
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
    Plug 'mattn/vim-lsp-icons'
call plug#end()
