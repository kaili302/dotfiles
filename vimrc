" Never put any lines in .vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html
"
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" {{{ install vim-plug if not yet
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug'

Plug 'scrooloose/nerdtree'

Plug 'jistr/vim-nerdtree-tabs'

Plug 'scrooloose/nerdcommenter'

Plug 'wesQ3/vim-windowswap'

Plug 'mileszs/ack.vim'

Plug 'joshdick/onedark.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'ntpeters/vim-better-whitespace'

Plug 'itchyny/lightline.vim' " Change StatusBar style

Plug 'kien/ctrlp.vim'

Plug 'vim-scripts/a.vim'

Plug 'tpope/vim-surround'
" ds'  -> delete both ', cs"' -> change " to '

" {{{ Language client for clangd
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Required for 'autozimu/LanguageClient-neovim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Required for 'autozimu/LanguageClient-neovim' auto completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp', {'do': 'pip3 install --user pynvim'}
    " Must install: pip3 install --user pynvim
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"}}}

" {{{ plugins black list
"
" Plug 'terryma/vim-multiple-cursors' " dont use this!!!!! hard to use
" Plug 'jiangmiao/auto-pairs'  dont use this!!!!! hard to use
"
"}}}

" All of your Plugins must be added before the following line
call plug#end()

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

" {{ LanguageClient_neovim
" Required for operations modifying multiple buffers like rename.
set hidden
" always show sign column, aka 'gutter'
set signcolumn=yes
" Add this plugin to vim/neovim runtimepath
set runtimepath+=~/.vim/bundle/LanguageClient-neovim
" Show list of all available actions
nnoremap <leader>y :call LanguageClient_contextMenu()<CR>
" Show type info (and short doc) of identifier under cursor
nnoremap <leader>yh :call LanguageClient#textDocument_hover()<CR>
" Goto definition under cursor.
nnoremap <leader>yd :call LanguageClient#textDocument_definition()<CR>
" Looks up the symbol under the cursor and jumps to its implementation (i.e.
" non-interface). If there are multiple implementations, instead provides a
" list of implementations to choose from.
nnoremap <leader>yi :call LanguageClient#textDocument_implementation()<CR>
" Rename identifier under cursor.
nnoremap <leader>yr :call LanguageClient#textDocument_rename()<CR>
" List all references of identifier under cursor.
nnoremap <leader>yref :call LanguageClient#textDocument_references()<CR>
" Show code actions at current location.
nnoremap <leader>yc :call LanguageClient#textDocument_codeAction()<CR>

" -cmake-extra-args: "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd', '-background-index',],
  \ }
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
