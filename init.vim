"
" @author: Girish Kumar, (zkmrgirish)
"
" last update: 03 Feb, Monday 


" you want vim, not vi. when vim finds a vimrc, 'nocompatible' is set anyway.
" we set it explicitly to make our position clear!
set nocompatible              " be improved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'shougo/deoplete.nvim', { 'do': ':updateremoteplugins' }

Plug 'fatih/vim-go'
Plug 'jiangmiao/auto-pairs'

" dependency for vimfiler
Plug 'shougo/unite.vim'
Plug 'shougo/vimfiler.vim'

" Comment:   use visual selection with :norm i<Comment-Chracter>
" Uncomment: use visual selection with :norm x
" Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'

call plug#end()            " required



" configure gopls? also disable guru in vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = "quickfix"
let g:go_doc_popup_window = 1

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
set wildignore+=*.swp,~*

" set relativenumber
set number
set nowrapscan
set autoread
set autowrite
set cursorline
set history=1000
set foldmethod=syntax
set foldlevelstart=2

set t_Co=256
set bg=dark
set statusline=%f\ \%{strftime('%I:%M\ %p,\ %A')}\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)


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

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm()
  " get current working direactory
  let s:current_direactory = expand('%:p:h')
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let s:float_term_border_win = nvim_open_win(border_buf, v:true, border_opts)
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatTermNormal term=None ctermbg=10
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatTermNormal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:FloatTermNormal')
  terminal zsh
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :q | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

command Terminal call FloatTerm()

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
command Vterm call VSplitTerminal()
command Sterm call SplitTerminal()

function HardMode()
    " disbale hjkl and arrow keys
    map h <NOP>
    map j <NOP>
    map k <NOP>
    map l <NOP>
endfunction

function EasyMode()
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


tnoremap <Esc> <C-\><C-n>
noremap <Leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <Leader><Tab> <Esc>/<++><Enter>"_c4l

" insert mapping for auto pairs
" inoremap " ""<Left>
" inoremap ' ''<Left>
" inoremap { {}<Left>
" inoremap {<CR> {}<Left><CR><CR><UP><Tab>
" inoremap [ []<Left>
" inoremap ( ()<Left>

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

nnoremap <Leader>ls :ls<CR>:b<Left>
nnoremap zz zz7<C-e>

nnoremap <Space> i<Space><Right><Esc>
nnoremap <Tab> <C-w><C-w>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprev<CR>
nnoremap <Leader>d :bd! term:*<C-a><CR>

" For comment and uncomment
noremap <C-n> <S-v>:norm 
vnoremap <C-n> :norm 

nnoremap <leader>comp :-1read $HOME/.vim/snippets/competitive.cpp<cr>/<++><cr>cf>

cnoreabbrev <expr> vfind ((getcmdtype() is# ':' && getcmdline() is# 'vfind')?('vertical sfind'):('vfind'))
" cnoreabbrev vfind vertical sfind
cnoreabbrev ctag autocmd BufWritePost * call system("ctags -R")

map <Leader>r :VimFilerExplorer -winwidth=25<CR>
map gb <C-o>

iab <expr> cdate strftime('%d %b, %A')

autocmd InsertEnter * se cul

let g:webdevicons_conceal_nerdtree_brackets = 0
let g:go_fmt_command = "goimports"
let g:srcery_italic = 1


colorscheme industry
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

hi Comment guifg=#abcdef ctermfg=23
hi Normal     ctermbg=NONE guibg=NONE
hi EndOfBuffer guifg=#404040
hi StatusLine guibg=#222222
hi LineNr     ctermbg=NONE guibg=#4f4f4f guifg=#abcdef
hi TabLine    guifg=white  guibg=#4f4f4f
hi TabLineFill guifg=#4f4f4f
hi TabLineSel guifg=#abcdef
hi CursorLineNr guifg=#52f752
hi VertSplit  guifg=#404040 guibg=#abcdef
hi SignColumn ctermbg=NONE guibg=NONE
hi Pmenu    guifg=#abcdef guibg=#4f4f4f
hi Search guibg=#abcdef guifg=black
hi Comment cterm=italic
