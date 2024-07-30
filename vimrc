vim9script
syntax enable
command! -nargs=1 G execute ':!git <args>'

# [[ Global Options ]]
for [var, val] in items({
        is_posix: 1,
        mapleader: ';',
        netrw_banner: 0,
        netrw_liststyle: 3,
        lsp_settings_filetype_vue: [
            'volar-server', 
            'eslint-language-server',
            'typescript-language-server'
        ]
})
    execute 'g:' .. var .. ' = ' .. string(val)
endfor

# [[ Editor Settings ]]
for option in [
        'number',
        'hlsearch',
        'incsearch',
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
        'relativenumber'
]
    execute 'set ' .. option
endfor

# [[ Key Mappings ]]
for [key, cmd] in items({
        '<C-h>': '<C-w>h',
        '<C-j>': '<C-w>j',
        '<C-k>': '<C-w>k',
        '<C-l>': '<C-w>l',
        '<Esc>': '<cmd>nohlsearch<cr>',
        '[d': '<cmd>LspPreviousDiagnostic<cr>',
        ']d': '<cmd>LspNextDiagnostic<cr>',
        'ga': '<plug>(lsp-action)',
        'gd': '<plug>(lsp-definition)',
        'gh': '<plug>(lsp-hover)',
        'gi': '<plug>(lsp-implementation)',
        'gr': '<plug>(lsp-references)',
        'gs': '<plug>(lsp-document-symbol-search)',
        'gt': '<plug>(lsp-type-definition)',
        '<leader>rn': '<plug>(lsp-rename)',
        '<leader>f': '<cmd>Files<cr>',
        '<leader>b': '<cmd>Buffers<cr>',
        '<leader>g': '<cmd>Rg<cr>',
        '<leader>c': '<cmd>Commits<cr>'
})
    execute 'nnoremap ' .. key .. ' ' .. cmd
endfor

# [[ Vim Plug Setup ]]
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

# [[ Plugin List ]]
call plug#begin()
    Plug 'lunacookies/vim-colors-xcode'
    Plug 'mattn/emmet-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'mityu/vim-wispath'
    Plug 'Eliot00/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-rsi'
    Plug 'github/copilot.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

# [[ Colorscheme Configuration ]]
colorscheme xcodedark
for [group, settings] in items({
        'Normal': 'guibg=NONE ctermbg=NONE',
        'EndOfBuffer': 'guibg=NONE ctermbg=NONE',
})
    execute 'hi ' .. group .. ' ' .. settings
endfor
