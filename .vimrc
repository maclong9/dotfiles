" Plugins
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'yegappan/lsp'
call plug#end()

" Options
syntax on
let g:mapleader = " "

set tabstop=2
set shiftwidth=2
set background=dark
set scrolloff=0
set mouse=a
set nowrap

for option in [
    \ 'nocompatible',
    \ 'relativenumber',
    \ 'hlsearch',
    \ 'cindent',
    \ 'incsearch',
    \ 'ignorecase',
    \ 'smartcase',
    \ 'linebreak',
    \ 'expandtab',
\ ]
  execute 'set '.option
endfor

" Keymaps
nmap <leader>ff :Files<cr>
nmap <leader>ft :Colors<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fw :Rg<cr>
nmap <leader>fm :Marks<cr>
nmap <leader>fC :Commands<cr>
nmap <leader>fk :Maps<cr>
nmap <leader>fc :Commits<cr>
nmap <leader>fs :LspOutline<cr>
nmap <leader>la :LspCodeAction<cr>
nmap <leader>ld :LspDiag current<cr>
nmap <leader>lf :LspFormat<cr>
nmap <leader>lr :LspRename<cr>
nmap gd         :LspGotoDeclaration<cr>
nmap ]d         :LspDiag next<cr>
nmap [d         :LspDiag prev<cr>

" Language Server Protocol
autocmd User LspSetup call LspOptionsSet(#{
        \   aleSupport: v:false,
        \   autoComplete: v:true,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:true,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'case',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:false,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:false,
        \   omniComplete: v:null,
        \   outlineOnRight: v:false,
        \   outlineWinSize: 20,
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:false,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:false,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
	\ })
autocmd User LspSetup call LspAddServer([#{
	\	  name: 'typescript',
	\	  filetype: ['ts', 'tsx'],
	\	  path: '/opt/homebrew/bin/deno',
	\ }])
