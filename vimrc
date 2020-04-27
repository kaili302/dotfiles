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

Plug 'tpope/vim-surround'
" ds'  -> delete both ', cs"' -> change " to '

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" {{{ Optional
" Plug 'tpope/vim-fugitive' " tmux and git alias are good enough
" Plug 'vim-scripts/DoxygenToolkit.vim' don't need at BB
" }}}

" {{{ plugins black list
" Plug 'junegunn/fzf.vim'  " CtrlP is easier to use
" Plug 'terryma/vim-multiple-cursors' " dont use this!!!!! hard to use
" Plug 'jiangmiao/auto-pairs'  dont use this!!!!! hard to use
" Plug 'octol/vim-cpp-enhanced-highlight' color is not very useful
" Plug 'itchyny/lightline.vim' " Use bling/vim-airline instead
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

" Syntax Highlighting with JSONC
autocmd FileType json syntax match Comment +\/\/.\+$+

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

"strip all trailing whitespace everytime you save the file for all file types
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" {{ coc.nvim
"
":CocConfig
"{
	""languageserver": {
		""clangd": {
			""command": "clangd",
			""rootPatterns": ["compile_flags.txt", "compile_commands.json"],
			"// By default, clangd only knows the files you are currently editing.
			"// To provide project-wide code navigations (e.g. find references),
			"// clangd neesds a project-wide index. clangd will incrementally build
			"// an index of the project in the background in {project_roote}/.cland/
			""args": ["--background-index"],
			""filetypes": ["c", "cpp"]
		"}
	"}
"}

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> D <Plug>(coc-definition)
" Remap keys for applying codeAction to the current line.
nmap <silent> F <Plug>(coc-codeaction)
" Show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Statusline support.
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'ERROR:'
"}}}

" {{{ airblade/vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" Toggle Highlighting
nnoremap <leader>h :GitGutterLineHighlightsToggle<CR>
" command to fold all unchanged lines, leaving just the hunks visible
nnoremap <leader>hf :GitGutterFold<CR>
"Call the GitGutterGetHunkSummary() function from your status line to get a
"list of counts of added, modified, and removed lines in the current buffer.

" stage the hunk with <Leader>hs
" undo a hunk with <Leader>hu.
" To stage part of any hunk:
"   - preview the hunk, e.g. <Leader>hp;
"   - move to the preview window
"   - delete the lines you do not want to stage
"   - stage the remaining lines: either write (:w) or <leader>hs
"
"When you make a change to a file tracked by git, the diff markers should
"appear automatically. The delay is governed by vim's updatetime option the
"default value is 4000, i.e. 4 seconds, but I suggest reducing it to around
"100ms (add set updatetime=100 to your vimrc). Note updatetime also controls
"the delay before vim writes its swap file (see :help updatetime).
set updatetime=100

" Prefer non-gitgutter signs, default is 10
let g:gitgutter_sign_priority=1
"}}}

" {{{ bling/vim-airline
let g:airline_theme='murmur'
"}}}

" {{{ fugitive.vim
nnoremap <leader>g :Git<space>
nnoremap <leader>gs :Git status -sb<CR>
nnoremap <leader>gd :Git diff -w --color=always<CR>
nnoremap <leader>gb :Git branch<CR>
nnoremap <leader>gc :Git checkout<space>
nnoremap <leader>gl :Git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit<CR>
" }}}

" {{{ fzf
" open file in new tab with <Enter>
let g:fzf_action = { 'ctrl-m': 'tab split'}

nnoremap <C-p> :GFiles<CR>
" Empty value to disable preview window altogether
let g:fzf_preview_window = ''
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" }}}

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
