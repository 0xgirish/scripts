"
" @author: Girish Kumar, (zkmrgirish)
"
" last update: 20 Nov, Wednesday 


" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitly to make our position clear!
set nocompatible              " be iMproved, required filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'jiangmiao/auto-pairs'

" dependency for vimfiler
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-commentary'

call plug#end()            " required



" configure gopls? also disable guru in vim-go
" remove this after getting a good gopls setup?
let g:go_null_module_warning = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = "quickfix"


let g:vimfiler_as_default_explorer = 1

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline_section_b = '%{strftime("%H:%M")}'
" let g:airline_section_y = 'BN: %{bufnr("%")}'
" let g:airline_theme='onedark'

let g:netrw_menu = 0

let mapleader = ","

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set encoding=UTF-8
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set tabstop=4
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

" set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set scrolloff=10

" set path to search files in subfolders and autocomplete on tab completion
set path=**
set wildmenu

set relativenumber
set number
set nowrapscan
set autoread
set autowrite
set cursorline
set history=100
set foldmethod=syntax
set foldlevelstart=2

" set bg=dark

noremap <Leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <Leader><Tab> <Esc>/<++><Enter>"_c4l

" insert mapping for auto pairs
" inoremap " ""<Left>
" inoremap ' ''<Left>
" inoremap { {}<Left>
" inoremap {<CR> {}<Left><CR><CR><UP><Tab>
" inoremap [ []<Left>
" inoremap ( ()<Left>

let g:netrw_liststyle = 3


augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
  
function! NetrwMapping()
    noremap <buffer> s <C-w><C-v><C-w>60>
endfunction

function FindText(text)
    " extenstion of the current file
    let b:pattern="**/*.". expand('%:e')
    exe "vim /". a:text ."/". b:pattern
endfunction

command! -nargs=1 Find call FindText(<f-args>)

function HardMode()
    " disbale hjkl and arrow keys
    map h <NOP>
    map j <NOP>
    map k <NOP>
    map l <NOP>
endfunction

function EasyMode()
    echo "You are weak"
    unmap h
    unmap j
    unmap k
    unmap l
endfunction

command Hard call HardMode()
command Easy call EasyMode()


" disbale use of arrow keys in normal mode
map <Left> <C-w>h
map <Down> <C-w>j
map <Up> <C-w>k
map <Right> <C-w>l

" always keep current line at center
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

nnoremap <Leader>lb :ls<CR>:b<Left>
nnoremap zz zz7<C-e>

nnoremap <Space> i<Space><Right><Esc>
nnoremap <Tab> <C-w><C-w>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprev<CR>

tnoremap <Tab> <C-w><C-w>

cnoreabbrev <expr> vfind ((getcmdtype() is# ':' && getcmdline() is# 'vfind')?('vertical sfind'):('vfind'))
cnoreabbrev ctag autocmd BufWritePost * call system("ctags -R")
map <Leader>r :VimFilerExplorer -winwidth=25<CR>
map gb <C-o>

iab <expr> cdate strftime('%d %b, %A')

autocmd InsertEnter * se cul

let g:webdevicons_conceal_nerdtree_brackets = 0
let g:go_fmt_command = "goimports"
let g:srcery_italic = 1

colorscheme industry

"Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

hi Comment guifg=#5C6370
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment cterm=italic
