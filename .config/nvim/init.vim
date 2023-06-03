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
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
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
autocmd FileType gitcommit setlocal spell

set et ts=4 sw=4
"set tw=105 cc=105

if has('persistent_undo')             "check if your vim version supports
  set undodir=$HOME/.cache/.vim/undo  "directory where the undo files will be stored
  set undofile                         "turn on the feature
endif

" Rust analyzer magic
"lua require'lspconfig'.rust_analyzer.setup({})
"map <leader>n :lua vim.lsp.diagnostic.goto_next()<cr>
"map <leader>p :lua vim.lsp.diagnostic.goto_prev()<cr>
"set omnifunc=v:lua.vim.lsp.omnifunc
"" Auto-format *.rs (rust) files prior to saving them
"autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
--require('lspconfig')['bashls']  .setup{ on_attach = on_attach, flags = lsp_flags, };

require('lspconfig')['pyright'] .setup{ on_attach = on_attach, flags = lsp_flags, }
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

EOF
