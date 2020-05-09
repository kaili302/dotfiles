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

Plug 'bling/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'mileszs/ack.vim'

Plug 'joshdick/onedark.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'ntpeters/vim-better-whitespace'

Plug 'vim-scripts/a.vim'

Plug 'airblade/vim-gitgutter'

Plug 'kien/ctrlp.vim'

" Install for Linux
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'tpope/vim-fugitive' " example: :G blame

Plug 'tpope/vim-surround'
" ds'  -> delete both ', cs"' -> change " to '

Plug 'valloric/youcompleteme'

" {{{ Optional
" Plug 'vim-scripts/DoxygenToolkit.vim' don't need at BB
" }}}

" {{{ plugins black list
" Plug 'junegunn/fzf.vim'  " CtrlP is easier to use
" Plug 'terryma/vim-multiple-cursors' " dont use this!!!!! hard to use
" Plug 'jiangmiao/auto-pairs'  dont use this!!!!! hard to use
" Plug 'octol/vim-cpp-enhanced-highlight' color is not very useful
" Plug 'itchyny/lightline.vim' " Use bling/vim-airline instead
" Plug 'dense-analysis/ale'  too inconvenient. much worse than COC
" Plug 'autozimu/LanguageClient-neovim' worse than COC
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
map <C-f> <Nop>
nnoremap q: <nop>
nnoremap Q <nop>

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

" Syntax Highlighting with JSONC
autocmd FileType json syntax match Comment +\/\/.\+$+

colorscheme onedark

" CtrlP{{{
nnoremap <leader>cp :CtrlP<CR>
set wildignore+=*/tmp/*,*/cmake.bld/*,*/CMakeFiles/*,*.so,*.swp,*.zip
"ctrlp open in new tab"
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
" }}}

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

"strip all trailing whitespace everytime you save the file for all file types
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

"" GoTo code navigation.
"nmap <silent> cd <Plug>(coc-declaration)
"nmap <silent> cD <Plug>(coc-definition)
"nmap <silent> cf <Plug>(coc-fix-current)
"nmap <silent> cF <Plug>(coc-codeaction)
"nmap <silent> ci <Plug>(coc-implementation) " not for C family
"nmap <silent> cr <Plug>(coc-references)
"nmap <silent> cR <Plug>(coc-refactor)
"nmap <silent> cn <Plug>(coc-diagnostic-next-error)
"nmap <silent> cN <Plug>(coc-diagnostic-prev-error)
"nnoremap <silent> cH :call CocAction('doHover')<CR>
"nnoremap <silent> ch :call CocAction('showSignatureHelp')<CR>

" {{{ YCM
" Language-server related configuration
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = "/home/kli302/bin/clangd"
" clangd bug: Background-index cannot be enabled when "compile-commands-dir" is not specified.
let g:ycm_clangd_args = ['--log=error', '--compile-commands-dir=.', '--background-index', '--suggest-missing-includes', '--pretty', '-j=100', '--pch-storage=memory', '--completion-style=detailed', '--clang-tidy']

" Auto-Completion
let g:ycm_filetype_whitelist = {'cpp': 1}
"let g:ycm_semantic_triggers =  {
  "\   'c': ['->', '.'],
  "\   'cpp': ['->', '.', '::'],
  "\ }
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
nnoremap <silent> cd :YcmCompleter GoToDeclaration<CR>
nnoremap <silent> cD :YcmCompleter GoToDefinition<CR>
nnoremap <silent> cf :YcmCompleter FixIt<CR>
nnoremap <silent> cr :YcmCompleter GoToReferences<CR>
nnoremap <silent> cR :YcmCompleter RefactorRename<space>
nmap <silent> ch <plug>(YCMHover)
let g:ycm_auto_hover = ""
	" Vim is super slow if set to 'CursorHold', show popup on holding cursor
augroup MyYCMCustom
    " Hover syntax highlighting for C family
  autocmd!
  autocmd FileType c,cpp let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
augroup END

" UI Related
set signcolumn=yes
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
	" Defines where GoTo* commands result should be opened.
set completeopt-=preview
    " Do not open preview window on auto-complete

" YCM configuration
let g:ycm_log_level = 'error'

" }}}

" Statusline support.
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
"}}}

" {{{ airblade/vim-gitgutter
nmap hn <Plug>(GitGutterNextHunk)
nmap hN <Plug>(GitGutterPrevHunk)
" Toggle Highlighting
nnoremap hh :GitGutterLineHighlightsToggle<CR>
" command to fold all unchanged lines, leaving just the hunks visible
nnoremap hf :GitGutterFold<CR>
"Call the GitGutterGetHunkSummary() function from your status line to get a
"list of counts of added, modified, and removed lines in the current buffer.

set updatetime=10

" Prefer non-gitgutter signs, default is 10
let g:gitgutter_sign_priority=1
"}}}

" {{{ bling/vim-airline
let g:airline_theme='murmur'
"}}}

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
