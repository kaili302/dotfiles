" Never put any lines in .vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html
"
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

call plug#begin('~/.config/nvim/bundle')
Plug 'scrooloose/nerdtree'

Plug 'jistr/vim-nerdtree-tabs'

Plug 'scrooloose/nerdcommenter'

Plug 'wesQ3/vim-windowswap'

Plug 'bling/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'mileszs/ack.vim'

Plug 'joshdick/onedark.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'ntpeters/vim-better-whitespace' " Show trailing whitespace in red

Plug 'kien/ctrlp.vim'

Plug 'davidhalter/jedi-vim'

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
set ruler
set showmatch
set hlsearch
set ttyfast
set synmaxcol=128
syntax sync minlines=256
set ignorecase
set smartcase
set colorcolumn=79
set cinoptions+=g2,h2
colorscheme onedark
" Syntax Highlighting with JSONC
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}

" disable command historical view {{{
map <C-f> <Nop>
nnoremap q: <nop>
nnoremap Q <nop>
" }}}

" Clear highlighting on escape in normal mode {{{
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
"nnoremap <leader>n :set number scl=auto<CR>
"nnoremap <leader>nn :set nonumber scl=no<CR>
nnoremap <leader>n :set number<CR>
nnoremap <leader>nn :set nonumber<CR>
" }}}

" search from current line
nnoremap <leader>c :.,$s///gc


" {{{ NerdCommenter
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
    " For some reason, vim registers <C-/> as <C-_>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>
" }}}


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
"let g:ackprg = 'ag --nogroup --nocolor --column --ignore changelog'
let g:ackprg = 'ag --nogroup --column --ignore changelog'
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
