vim9script
g:is_posix = 1
syntax on
colorscheme habamax
highlight Normal ctermbg=none

for option: string in [
  'number',
  'relativenumber',
  'noswapfile',
  'cindent',
  'noshowmode',
  'cursorline',
  'incsearch',
  'expandtab',
  'tabstop=2',
  'shiftwidth=2',
]
  execute 'set ' .. option
endfor

augroup Formatting
    autocmd!
    autocmd FileType javascript,typescript,jsx,tsx,markdown,json 
      \ setlocal formatexpr=Deno\ fmt\ -
augroup END

augroup Writing
  autocmd!
  autocmd FileType markdown setlocal spell
augroup END
