"call pathogen#infect()
syntax on
set hlsearch
"set autoindent
"set cindent
set ts=4
set shiftwidth=4
set softtabstop=4
set backupdir=~/.backup,/tmp
set directory=~/.backup,/tmp
set nobackup

command Indent !indent %

set viminfo='0

set linebreak
set display+=lastline
set vb

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Linux kernel:
"    :set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
"

" http://michael.peopleofhonoronly.com/vim/
set nocompatible ruler laststatus=2 showcmd showmode shortmess+=l
"set number
set backspace=indent,eol,start
"set foldmethod=indent

" http://wiki.python.org/moin/Vim
set background=dark
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 cc=79

" Kind of dangerous...
set modeline

" For TI PRUSS files
au! BufNewFile,BufRead *.hp,*.p setf asm

" Disable folding for vim-markdown
let g:vim_markdown_folding_disabled=1

" 256 color support, ref: http://robotsrule.us/vim/
set t_Co=256

" Add support for fssh ui_copy/ui_paste
vmap <C-c> :w !ui_copy<cr><cr>
nmap <C-v> :r !ui_paste<cr><cr>
set expandtab
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

set mouse=r

if has("cscope")
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    "map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
    "map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Using 'CTRL-spacebar' then a search type makes the vim window
    " split horizontally, with search result displayed in
    " the new window.

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif
