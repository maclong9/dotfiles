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
