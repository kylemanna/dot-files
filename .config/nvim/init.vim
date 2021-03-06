"
"
"
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

set linebreak
set display+=lastline
set vb

if has("autocmd")
  " Uncomment the following to have Vim load indentation rules and plugins
  " according to the detected filetype.
  filetype plugin indent on
    
  " Uncomment the following to have Vim jump to the last position when
  " reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Kind of dangerous...
set modeline

" For TI PRUSS files
au! BufNewFile,BufRead *.hp,*.p setf asm

" Disable folding for vim-markdown
let g:vim_markdown_folding_disabled=1

" 256 color support, ref: http://robotsrule.us/vim/
set t_Co=256

" Add support for fssh ui_copy/ui_paste
"vmap <C-c> :w !ui_copy<cr><cr>
"nmap <C-v> :r !ui_paste<cr><cr>
set expandtab
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

set mouse=r

source ~/.config/nvim/cscope_maps.vim
"set cscoperelative

set exrc
set secure
autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy
