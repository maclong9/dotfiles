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
        ll: 'LspDiag current',
        lf: 'LspFormat',
        lo: 'LspOutline',
        lt: 'LspPeekTypeDef',
        ln: 'LspDiag nextWrap',
        lp: 'LspDiag prevWrap'
})
    execute 'nmap <leader>' .. map .. ' :' .. cmd .. '<cr>'
endfor

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'yegappan/lsp'
	Plug 'mattn/emmet-vim'
	Plug 'sheerun/vim-polyglot'
call plug#end()

autocmd User LspSetup call LspOptionsSet({autoHighlightDiags: v:true, outlineOnRight: v:true, usePopupInCodeAction: v:true})

var lspServers = [
    {
        name: 'clang',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/clangd',
        args: ['--background-index']
    },
    {
        name: 'typescript-language-server',
        filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
        path: 'typescript-language-server',
        args: ['--stdio'],
		runIfSearch: ['package.json']
    }
]

autocmd User LspSetup call LspAddServer(lspServers)
