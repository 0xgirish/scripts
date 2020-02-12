"
" @author: zkmrgirish
"
" last update: 12 Feb, Wednesday


" you want vim, not vi. when vim finds a vimrc, 'nocompatible' is set anyway.
" we set it explicitly to make our position clear!
set nocompatible              " be improved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" required for asynchronus update of plugins
Plug 'shougo/deoplete.nvim', { 'do': ':updateremoteplugins' }
Plug 'fatih/vim-go'

" dependency for vimfiler
Plug 'shougo/unite.vim'
Plug 'shougo/vimfiler.vim'

" vimwiki for note taking
Plug 'vimwiki/vimwiki'

" a minimal colorscheme
Plug 'andreypopp/vim-colors-plain'

call plug#end()            " required

" configure gopls? also disable guru in vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = "quickfix"
let g:go_doc_popup_window = 1
let g:go_fmt_command = "goimports"

let g:srcery_italic = 1

" remove this after getting a good gopls setup?
let g:go_null_module_warning = 0
let g:vimfiler_as_default_explorer = 1
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
set wildignore+=*.pyc,*.pyo,*/__pycache__/*,.git/*
set wildignore+=*.swp,~*,#*/**

" relativenumber is just a showoff, nobody uses them
" set number        " :set number when required
set nowrapscan
set autoread
set autowrite
set cursorline
set history=100
set foldmethod=syntax
set foldlevelstart=2

set t_Co=256
set bg=dark
set statusline=%f\ \%{strftime('%I:%M\ %p,\ %A')}\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

let g:netrw_liststyle = 3

function SplitTerminal()
    split term://zsh
    :res 7
    startinsert
endfunction

function VSplitTerminal()
    vsplit term://zsh
    :vertical res 50
    startinsert
endfunction

" commands for terminal split
cnoreabbrev <expr> vterm ((getcmdtype() is# ':' && getcmdline() is# 'vterm')?('call VSplitTerminal()'):('vterm'))
cnoreabbrev <expr> sterm ((getcmdtype() is# ':' && getcmdline() is# 'sterm')?('call SplitTerminal()'):('sterm'))

" use arrow keys to navigate windows
map <Left> <C-w>h
map <Down> <C-w>j
map <Up> <C-w>k
map <Right> <C-w>l

" change to different window
nnoremap <Tab> <C-w><C-w>

" auto-pairs like emulation
inoremap {<CR> {<CR>}<Esc>O
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O

" Use <Esc> to change to normal mode in neovim terminal
tnoremap <Esc> <C-\><C-n>
noremap <Leader><Tab> <Esc>/<++><Enter>"_c4l

" list buffers and change
nnoremap <Leader>ls :ls<CR>:b<Left>
nnoremap zz zz7<C-e>
nnoremap <Space> i<Space><Right><Esc>

nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprev<CR>

" delete all terminal buffers used by :Terminal
nnoremap <Leader>d :bd! term:*<C-a><CR>

" For comment and uncomment
noremap <C-n> <S-v>:norm 
vnoremap <C-n> :norm 

" find a file and show in vertical split
cnoreabbrev <expr> vfind ((getcmdtype() is# ':' && getcmdline() is# 'vfind')?('vertical sfind'):('vfind'))
map <Leader>r :VimFilerExplorer -winwidth=25<CR>
iab <expr> cdate strftime('%d %b, %A')

autocmd InsertEnter * se cul
colorscheme plain

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

hi Comment guibg=#404040 guifg=#abcdef ctermfg=23
hi Visual  guifg=#52f752
hi Normal     ctermbg=NONE guibg=NONE
hi EndOfBuffer guifg=#404040
hi StatusLineNC guibg=#4d4d4d guifg=#abcdef
hi StatusLine guibg=#4d4d4d guifg=#52f752
hi LineNr     ctermbg=NONE guibg=#4f4f4f guifg=#abcdef
hi TabLine    guifg=white  guibg=#4f4f4f
hi TabLineFill guifg=#4f4f4f
hi TabLineSel guifg=#abcdef
hi CursorLineNr guifg=#52f752
hi VertSplit  guifg=#404040 guibg=black
hi SignColumn ctermbg=NONE guibg=NONE
hi Pmenu    guifg=#abcdef guibg=#4f4f4f
hi Search guifg=#52f752 guibg=#4d4d4d
hi Comment cterm=italic
