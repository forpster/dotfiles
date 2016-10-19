"set ic ai sw=4 nows cindent cinkeys=0{,0},:,!^F,o,O,e shiftwidth=4 tabstop=4 expandtab
"map q :e#^M

" set tabs to be 4 spaces in width when displayed
set shiftwidth=4
set tabstop=4

" expand tabs to 4 spaces
set expandtab

set ignorecase

" turn on smart auto identing and c-specific indenting
set autoindent
set smartindent
set cindent

" don't wrap on a search
set nowrapscan

" highlight the brace/parenthese/bracket's "match" when entering a closing one
set showmatch

" remove ^M's :)
map q :%s/$//g

" add colours, if term supports it!
if &t_Co > 1
    syntax enable
endif
" using dark background
set bg=dark

if has("autocmd")
    filetype plugin on
    augroup te
        autocmd BufRead,BufNewFile          *.te set filetype=te
    augroup END
endif

" F8 to disable indenting!
:nnoremap <F8> :setl noai nocin nosi inde=<CR>

set tags=./tags
