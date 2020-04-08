"
" @author: zkmrgirish
"
" last update: 08 Apr, Wednesday

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

let mapleader = ","

packadd minpac
call minpac#init()

" let minpac update itself
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('vimwiki/vimwiki')

" my own sensible config for vim, main of the plugin is to minimize vimrc file
call minpac#add('zkmrgirish/sensible.vim')

" dependency for fzf
call minpac#add('junegunn/fzf', {'do': './install --bin'})
call minpac#add('junegunn/fzf.vim')

" for vim to look cool
call minpac#add('andreypopp/vim-colors-plain')
call minpac#add('itchyny/lightline.vim')

" different programming language plugins
call minpac#add('fatih/vim-go')
call minpac#add('rust-lang/rust.vim')

" dependency for vimfiler
call minpac#add('shougo/unite.vim')
call minpac#add('shougo/vimfiler.vim')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" configure gopls? also disable guru in vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = 'quickfix'
let g:go_doc_popup_window = 1
let g:go_fmt_command = 'goimports'

" configureation for rust.vim
let g:rustfmt_autosave = 1

let g:srcery_italic = 1

" remove this after getting a good gopls setup?
let g:go_null_module_warning = 0
let g:vimfiler_as_default_explorer = 1
let g:netrw_menu = 0
let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]

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

function TimeNow()
    return strftime('%I:%M %p, %A')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [ 'timenow' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ] ]
      \ },
      \ 'component_function': {
      \   'timenow': 'TimeNow',
      \ },
      \ }


" commands for terminal split
cnoreabbrev <expr> vterm ((getcmdtype() is# ':' && getcmdline() is# 'vterm')?('call VSplitTerminal()'):('vterm'))
cnoreabbrev <expr> sterm ((getcmdtype() is# ':' && getcmdline() is# 'sterm')?('call SplitTerminal()'):('sterm'))

" For comment and uncomment
noremap <C-n> <S-v>:norm 
vnoremap <C-n> :norm 

inoremap <Leader><Tab> <Esc>/<++><CR>"_c4l

" For FZF Buffer
noremap <Leader>ls :Buffers<CR>
noremap <Leader>lf :Files<CR>
noremap <Leader>L :Lines<CR>

" movement mappings
onoremap i( :<C-u>normal! f(vi(<CR>

map <Leader>r :VimFilerExplorer -winwidth=25<CR>

set updatetime=100

autocmd InsertEnter * se cul
colorscheme plain
