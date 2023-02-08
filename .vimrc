set relativenumber
set number
set path+=**
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set cursorline
set ai
set smartindent
set backspace=indent,eol
set nowrap
set ruler
set hlsearch
set laststatus=2
set paste
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE

syntax on

"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
"inoremap < <><Esc>i
"inoremap " ""<Esc>i
"inoremap ' ''<Esc>i
"inoremap {<CR> {<CR>}<Esc>ko
"inoremap {{ {}<ESC>i

"設定縮排的顯示符號，效果類似 Indent Guide
set list listchars=tab:\:\ ,trail:·,extends:?,precedes:?,nbsp:× 

"set background=dark
"set lines=35 columns=100 " the windows sieze when open vim


" call plug#begin()
" Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
" call plug#end()

