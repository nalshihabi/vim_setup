set runtimepath+=~/.vim_runtime

filetype off                            " required
set rtp+=~/.vim/bundle/Vundle.vim

" ==========================================================================================
" Vundle Setup Begin
" ==========================================================================================

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Call for my colors
source ~/.vim/colors.vim

" YouCompleteMe
Plugin 'valloric/youcompleteme'

" NERDTree
Plugin 'scrooloose/nerdtree'

" NERDCommenter
Plugin 'scrooloose/nerdcommenter'

" Syntastic
Plugin 'scrooloose/syntastic'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'

" Ale
Plugin 'w0rp/ale'

" Rust.vim
Plugin 'rust-lang/rust.vim'

" TypeScript
Plugin 'quramy/tsuquyomi'

" TypeScript Highlighting
Plugin 'leafgarland/typescript-vim'

" TypeScript React Highlighting
Plugin 'peitalin/vim-jsx-typescript'

" VIMPROC
Plugin 'shougo/vimproc.vim'

" PeakSea
Plugin 'peaksea'

" CCTree
Plugin 'hari-rangarajan/cctree'

" Flake8
Plugin 'nvie/vim-flake8'

" Space Vim Theme
Plug 'liuchengxu/space-vim-theme'

call vundle#end()            " required
filetype plugin indent on    " required

" ==========================================================================================
" Vundle Setup End
" ==========================================================================================


" source ~/.vim_runtime/vimrcs/basic.vim
" source ~/.vimrc_copy
source ~/.vim/filetypes.vim
" source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim/extended.vim

try
source ~/.vim/my_configs.vim
catch
endtry



" ==========================================================================================
" Begin regular settings
" ==========================================================================================

" Use the Solarized Dark theme
set background=dark
colorscheme space_vim_theme
" colorscheme solarized
" let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
" set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
" set backupdir=~/.vim/backups
" set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

set noswapfile
set nobackup

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
" set cursorline
" Make tabs as wide as two spaces
set tabstop=4
set expandtab
set smarttab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Remap moving up and down to not care about wrapped lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Remap moving up and down to not care about wrapped lines in visual mode
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" Cursor type based on mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" ==========================================================================================
" End regular settings
" ==========================================================================================

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"----------------------------------------
" NERDTree Settings
let g:NERDTreeWinPos = "left"

" Open NERDTree automatically when vim opens
autocmd vimenter * NERDTree

" Open NERDTree when no files are specified upon opening vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Keymap for opening and closing NERDTree
map <C-e> :NERDTreeToggle<CR>

" Closes Vim automatically when NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files and folders
let NERDTreeShowHidden=1

"----------------------------------------
" Backspace changes
" func Backspace()
"   if col('.') == 1
"     if line('.')  != 1
"       return  "\<ESC>kA\<Del>"
"     else
"       return ""
"     endif
"   else
"     return "\<Left>\<Del>"
"   endif
" endfunc
" inoremap <BS> <c-r>=Backspace()<CR>

"----------------------------------------
" Ctrl-p Settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Set ignore values
let g:ctrlp_custom_ignore = '\v[\/](node_modules|\.git)\/'

" Set default to use file name search
let g:ctrlp_by_filename = 1

"----------------------------------------
" YouCompleteMe
let g:ycm_rust_binary_path='/Users/noah/.cargo/bin'
let g:ycm_autoclose_preview_window_after_insertion = 1

"----------------------------------------
" Split Changes
set splitright
set splitbelow

"----------------------------------------
" Language tabbing specific
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"----------------------------------------
" Day an night settings
:command Day set background=light
:command Night set background=dark

"----------------------------------------
" Window Resizing Settting
set noea

"----------------------------------------
" Color Column 80
set colorcolumn=80

"----------------------------------------
" MUST be last command
autocmd VimEnter * 2wincmd w