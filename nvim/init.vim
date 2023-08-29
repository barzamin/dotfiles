call plug#begin()

" rice
Plug 'Yggdroot/indentLine'

" utils
Plug 'tpope/vim-rsi'

" finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }


call plug#end()

nnoremap , <Nop>
let mapleader = ','

set colorcolumn=80

