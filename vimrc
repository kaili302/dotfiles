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

Plugin 'tpope/vim-surround'
" ds'  -> delete both ', cs"' -> change " to '

"{{{ Install YouCompleteMe with clangd
Plugin 'Valloric/YouCompleteMe'
" Needs to compile YCM locally
"
"cd ~/.vim/bundle/YouCompleteMe
"python3 install.py --clangd-completer
"}}}


" {{{ plugins black list
"
" Plugin 'terryma/vim-multiple-cursors' " dont use this!!!!! hard to use
" Plugin 'jiangmiao/auto-pairs'  dont use this!!!!! hard to use
"
"}}}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
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

set backspace=indent,eol,start " make the backspace work nicely
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

let g:ycm_global_ycm_extra_conf = '/home19/kli302/.vim/ycm_extra_conf.py'

" Show C++ syntax error in Vim gutter (the signs column)
let g:ycm_show_diagnostics_ui = 1

" Maximum number of errors or warnings diagnostics shown to the user
let g:ycm_max_diagnostics_to_display = 30

" YCM will auto-close the preview window after the user accepts the offered
" completion string
let g:ycm_autoclose_preview_window_after_completion = 1

" If set to 0, turns off YCM's identifier completer (the as-you-type popup) and
" the semantic triggers (the popup you'd get after typing . or -> in say C++).
let g:ycm_auto_trigger = 1

" Only enable YCM and clangd for CPP
let g:ycm_filetype_whitelist = {'cpp': 1}

"This command attempts to find all of the references within the project to the
"identifier under the cursor and populates the quickfix list with those
"locations.
let g:ycm_complete_in_strings = 1

"
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \ }

let g:ycm_path_to_python_interpreter="/opt/bb/bin/python"

"always show gutter aka sign column, and clear its colour
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
highlight clear SignColumn

"shortcuts
nnoremap <leader>y :YcmCompleter<SPACE>

" Fix it
nnoremap <leader>ft :YcmCompleter FixIt<CR>

" Looks up the current line for a header and jumps to it.
nnoremap <leader>yi :YcmCompleter GoToInclude<CR>

" https://github.com/ycm-core/YouCompleteMe#the-gotoimprecise-subcommand
nnoremap <leader>yd :YcmCompleter GoToImprecise<CR>

" This command attempts to find all of the references within the project to
" the identifier under the cursor and populates the quickfix list with those
" locations.
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>

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
