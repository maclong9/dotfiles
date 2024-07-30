vim9script
syntax enable
command! -nargs=1 G execute ':!git <args>'

# [[ Global Options ]]
for [var, val] in items({
        is_posix: 1,
        mapleader: ';',
        netrw_banner: 0,
        netrw_liststyle: 3,
        indentLine_char: '│',
        lsp_settings_filetype_typescript: ['eslint-language-server', 'typescript-language-server'],
        lsp_settings_filetype_vue: ['eslint-language-server', 'typescript-language-server', 'volar-server']
})
    execute 'g:' .. var .. ' = ' .. string(val)
endfor

# [[ Editor Settings ]]
for option in [
        'breakindent',
        'cursorline',
        'hlsearch',
        'incsearch',
        'mouse=a',
        'noshowmode',
        'noswapfile',
        'number',
        'regexpengine=0',
        'signcolumn=no',
        'relativenumber',
        'scrolloff=999',
        'shiftwidth=2',
        'smartindent',
        'tabstop=2',
]
    execute 'set ' .. option
endfor

# [[ Key Mappings ]]
for [key, cmd] in items({
        '<C-a>': '<plug>(lsp-action)',
        '<C-h>': '<C-w>h',
        '<C-j>': '<C-w>j',
        '<C-k>': '<C-w>k',
        '<C-l>': '<C-w>l',
        '<Esc>': '<cmd>nohlsearch<cr>',
        '<leader>e': '<cmd>Explore<cr>',
        '<leader>f': '<cmd>Files<cr>',
        '<leader>g': '<cmd>Rg<cr>',
        'ga': '<plug>(lsp-code-action)',
        'gd': '<plug>(lsp-definition)',
        'gh': '<plug>(lsp-hover)',
        'gi': '<plug>(lsp-implementation)',
        'gn': '<cmd>LspNextDiagnostic<cr>',
        'gp': '<cmd>LspPreviousDiagnostic<cr>',
        'gr': '<plug>(lsp-rename)',
        'gs': '<plug>(lsp-document-symbol-search)',
        'gt': '<plug>(lsp-type-definition)'
})
    execute 'nnoremap ' .. key .. ' ' .. cmd
endfor

# [[ Plugin List ]]
call plug#begin()
    Plug 'Eliot00/auto-pairs'
    Plug 'github/copilot.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'lunacookies/vim-colors-xcode'
    Plug 'mattn/emmet-vim'
    Plug 'mattn/vim-lsp-settings'
    Plug 'mityu/vim-wispath'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'yggdroot/indentline'
call plug#end()

# [[ Colorscheme Configuration ]]
colorscheme xcodedark
for [group, settings] in items({
        'EndOfBuffer': 'guibg=NONE ctermbg=NONE',
        'Normal': 'guibg=NONE ctermbg=NONE'
})
    execute 'hi ' .. group .. ' ' .. settings
endfor

# [[ Auto Commands ]]
augroup EslintOnSave
    autocmd!
    autocmd BufWritePost *.vue,*.ts silent! execute '!eslint --fix %'
augroup END
