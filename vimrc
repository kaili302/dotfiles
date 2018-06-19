" Never put any lines in .vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html
"

" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'

Plugin 'scrooloose/nerdtree'

"Plugin 'scrooloose/nerdcommenter'

"Plugin 'jiangmiao/auto-pairs'

Plugin 'joshdick/onedark.vim'

Bundle 'christoomey/vim-tmux-navigator'

Plugin 'ntpeters/vim-better-whitespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" Leader {{{
let mapleader=","
" }}}

" Basic {{{
syntax on
set mouse=nicr
set number
set cul!
set encoding=utf-8
set spell spelllang=en_us

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" }}}

" Spaces and Tabs {{{
set tabstop=4               " number of visual spaces per TAB
set softtabstop=4           " number of spaces inserted/deleted while editing
set expandtab               " tabs are spaces
set shiftwidth=4            " an indent is 4 spaces
set shiftround              " round to nearest multiple of shiftwidth
filetype indent on
filetype plugin on
set autoindent              " auto indent
set smartindent             " smart indent

set backspace=indent,eol,start " make the backspace work like in most other programs
" }}}

" TODO


set ruler
set showmatch
"colorscheme onedark
" Uncomment below to make screen not flash on error
" set vb t_vb=""

set colorcolumn=100

set cinoptions+=g2,h2

colorscheme onedark

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let NERDTreeIgnore = ['\.pyc$']


map<C-n> :NERDTreeToggle<CR>
map <Leader>vp :VimuxPromptCommand<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

set hlsearch

set ttyfast
set lazyredraw

set synmaxcol=128
syntax sync minlines=256

set ignorecase
set smartcase

"fzf finder
set rtp+=~/.fzf
nnoremap <leader>p :Files <CR>
nnoremap <C-p> :Files <CR>
nnoremap <leader>b :Buffers <CR>
nnoremap \ :Buffers <CR>

"always show gutter aka sign column, and clear its colour
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
highlight clear SignColumn

"Only enable ycm for certain types of file
"let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, "py": 1}

nnoremap H gT
nnoremap L gt
nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-Delete> :tabclose<CR>

"strip all trailing whitespace everytime you save the file for all file types
autocmd BufEnter * EnableStripWhitespaceOnSave

