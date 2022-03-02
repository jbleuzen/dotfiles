call plug#begin()
" Appearance
Plug 'jbleuzen/molokai'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'

" Utilities
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'

" Completion / linters / formatters
Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
Plug 'plasticboy/vim-markdown'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()

" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

colorscheme molokai

let mapleader = ","



" Move to previous/next
nnoremap <silent>    <Left> :BufferPrevious<CR>
nnoremap <silent>    <Right> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>


nnoremap <F5> :source $MYVIMRC<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

" NERDTree
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
nnoremap <silent> <leader>d :NERDTreeToggle<CR>

" Barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.tabpages = v:true
let bufferline.closable = v:true
let bufferline.icons = v:false
let bufferline.icon_separator_active = '|'
let bufferline.icon_separator_inactive = ''
let bufferline.icon_close_tab_modified = '●'
let bufferline.icon_close_tab= ''
