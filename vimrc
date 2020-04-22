" Never put any lines in .vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html
"
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

Bundle 'jistr/vim-nerdtree-tabs'

Plugin 'scrooloose/nerdcommenter'

Plugin 'wesQ3/vim-windowswap'

Plugin 'mileszs/ack.vim'

Plugin 'joshdick/onedark.vim'

Bundle 'christoomey/vim-tmux-navigator'

Plugin 'ntpeters/vim-better-whitespace'

Plugin 'itchyny/lightline.vim' " Change StatusBar style

Plugin 'kien/ctrlp.vim'

Plugin 'vim-scripts/a.vim'

" Plugin 'terryma/vim-multiple-cursors' " dont use this!!!!! hard to use

" Plugin 'jiangmiao/auto-pairs'  dont use this!!!!! hard to use

Plugin 'tpope/vim-surround'
" ds'  -> delete both ', cs"' -> change " to '


"Plugin 'Valloric/YouCompleteMe'

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

" Paste mode and Number mode {{{
nnoremap <leader>p :set paste<CR>
nnoremap <leader>np :set nopaste<CR>
nnoremap <leader>n :set number<CR>
nnoremap <leader>nn :set nonumber<CR>
" }}}

set ruler
set showmatch
" Uncomment below to make screen not flash on error
" set vb t_vb=""

set hlsearch

set ttyfast

set synmaxcol=128
syntax sync minlines=256

set ignorecase
set smartcase

" search from current line
nnoremap <leader>c :.,$s///gc


set colorcolumn=79

set cinoptions+=g2,h2

colorscheme onedark

" NerdTree {{{
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let NERDTreeIgnore = ['\.pyc$']
map<C-n> :NERDTreeTabsToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" }}}

" ag + ack.vim {{{
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <leader>s :Ack<space>
" }}}

" CtrlP{{{
nnoremap <leader>cp :CtrlP<CR>
set wildignore+=*/tmp/*,*/cmake.bld/*,*/CMakeFiles/*,*.so,*.swp,*.zip

" }}}

"always show gutter aka sign column, and clear its colour
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
highlight clear SignColumn

"strip all trailing whitespace everytime you save the file for all file types
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

"ctrlp open in new tab"
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

"LightVim {{{
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }
"}}}

"multi-cursors {{{
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_start_key           = 'g<C-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-r>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
"}}}

"YouCompleteMe {{{
"-----------------------------------
"let g:ycm_global_ycm_extra_conf = '/bb/mbigh/mbig6544/MODA/moda-ycm/ycm_extra_conf.py'
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_max_diagnostics_to_display = 1000
"let g:ycm_always_populate_location_list = 1
"let g:ycm_autoclose_preview_window_after_completion = 1

"this is experimental, these should be default settings!
"let g:ycm_auto_trigger = 1
"let g:ycm_semantic_triggers =  {
  "\   'c' : ['->', '.'],
  "\   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  "\             're!\[.*\]\s'],
  "\   'ocaml' : ['.', '#'],
  "\   'cpp,objcpp' : ['->', '.', '::'],
  "\   'perl' : ['->'],
  "\   'php' : ['->', '::'],
  "\   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  "\   'ruby' : ['.', '::'],
  "\   'lua' : ['.', ':'],
  "\   'erlang' : [':'],
  "\ }
"let g:ycm_path_to_python_interpreter="/opt/bb/bin/python"

"diagmode of ycm
"nnoremap <F3> <Esc> :YcmDiags<CR>
"nnoremap <F2> :YcmCompleter FixIt<CR>
"nnoremap <F7> :YcmCompleter GoToDefinition<CR>
"nnoremap <F8> :YcmCompleter GoToDeclaration<CR>

"Only enable ycm for certain types of file
"let g:ycm_filetype_whitelist = { 'cpp': 1}
 "}}}

nnoremap <leader>p :set paste<CR>
nnoremap <leader>np :set nopaste<CR>
nnoremap <leader>n :set number<CR>
nnoremap <leader>nn :set nonumber<CR>

" Use Ctrl+O in Insert mode to run one Normal mode command {{{

"jump to end of line while in Insert Mode
inoremap <C-e> <C-o>$

"jump to begin of line while in Insert Mode
inoremap <C-a> <C-o>0

"delete current line while in Insert Mode
inoremap <C-d> <C-o>dd

"save current file while in Insert Mode
inoremap <C-s> <Esc>:w<Enter>
" }}}

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

""" Help Documents {{{

" Key mapping {
" <BS>           Backspace
" <Tab>          Tab
" <CR>           Enter
" <Enter>        Enter
" <Return>       Enter
" <Esc>          Escape
" <Space>        Space
" <Up>           Up arrow
" <Down>         Down arrow
" <Left>         Left arrow
" <Right>        Right arrow
" <Insert>       Insert
" <Del>          Delete
" <Home>         Home
" <End>          End
" <bar>          the '|' character, which otherwise needs to be escaped '\|'
" } End Key mapping

" }}}
