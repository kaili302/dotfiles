" Never put any lines in .vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html
"
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" {{{ install vim-plug if not yet
"if empty(glob('~/.vim/autoload/plug.vim'))
  "silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    "\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
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

Plug 'kien/ctrlp.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Install for Linux
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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
"Plug 'tpope/vim-fugitive' " example: :G blame
"Plug 'tpope/vim-surround'
"" ds'  -> delete both ', cs"' -> change " to '
"Plug 'airblade/vim-gitgutter'
"Plug 'davidhalter/jedi-vim'
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
" {{{ disable command historical view
map <C-f> <Nop>
nnoremap q: <nop>
nnoremap Q <nop>
" }}}
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

" {{{ NerdCommenter
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
    " For some reason, vim registers <C-/> as <C-_>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>
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
nnoremap <leader>l :.,$s///gc

set colorcolumn=79

set cinoptions+=g2,h2

" Syntax Highlighting with JSONC
autocmd FileType json syntax match Comment +\/\/.\+$+

colorscheme onedark

" CtrlP{{{
nnoremap <leader>cp :CtrlP<CR>
set wildignore+=*/tmp/*,*/cmake.bld/*,*/cmake-*,*/CMakeFiles/*,*.so,*.swp,*.zip
"ctrlp open in new tab"
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
" }}}

" NerdTree {{{
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.d$']
map<C-n> :NERDTreeTabsToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" }}}

" ag + ack.vim {{{
"let g:ackprg = 'ag --nogroup --nocolor --column --ignore changelog'
let g:ackprg = 'ag --nogroup --column --ignore changelog'
nnoremap <leader>s :Ack<space>
" }}}

" {{{ strip all trailing whitespace everytime you save the file for all file types
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"}}}


" CoC Plugins {{{
"" Install Plugins if not exist
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-cmake',
        \ 'coc-html', 'coc-json', 'coc-sql', 'coc-clangd']

map <leader>cp :CocList commands<CR>
map <leader>ce :CocList extensions<CR>
"? means invalid extension
"* means extension is activated
"+ means extension is loaded
"- means extension is disabled
"hit <Tab> to activate action menu
" }}}

" CoC Display {{{
set hidden " TextEdit might fail if hidden is not set.
set nobackup
set nowritebackup " Some servers have issues with backup files, see #649.
set cmdheight=2 " Give more space for displaying messages.
set updatetime=300 " Having longer updatetime (default is 4 s) leads to noticeable delays and poor user experience.
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
if has("patch-8.1.1564") " Always show the signcolumn, otherwise it shifts the text each timediagnostics appear/become resolved.
  set signcolumn=number " Recently vim can merge signcolumn and number column into one
else
  set signcolumn=yes
endif
" }}}


" CoC auto-completion {{{
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" make <cr> select the first completion item and confirm the completion when no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use <cr> to confirm completion
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <cr> to confirm completion and format your code on <cr>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" CoC Shortcuts {{{
nmap <silent> cd <Plug>(coc-declaration)
nmap <silent> cD <Plug>(coc-definition)
nmap <silent> cf <Plug>(coc-fix-current)
nmap <silent> cF <Plug>(coc-codeaction)
nmap <silent> ci <Plug>(coc-implementation) " not for C family
nmap <silent> cr <Plug>(coc-references)
nmap <silent> cR <Plug>(coc-refactor)
nmap <silent> cn <Plug>(coc-diagnostic-next-error)
nmap <silent> cN <Plug>(coc-diagnostic-prev-error)
nnoremap <silent> cH :call <SID>show_documentation()<CR>
nnoremap <silent> ch :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Statusline support.
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
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

" {{{ bling/vim-airline
let g:airline_theme='murmur'
"}}}




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
