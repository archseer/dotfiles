" ---------------------------------------------------------------------------
" Vundle
" ---------------------------------------------------------------------------

set nocompatible
filetype off                " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Plugin 'godlygeek/csapprox'
Plugin 'chriskempson/base16-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
Plugin 'othree/yajs.vim'
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'sheerun/vim-polyglot'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
if has('lua')
  Plugin 'Shougo/echodoc.vim'
  Plugin 'Shougo/neocomplete.vim'
endif
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Plugin 'ctrlpvim/ctrlp.vim'

runtime macros/matchit.vim

call vundle#end()
filetype plugin indent on

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------
let mapleader=" "

set history=1000          " keep some stuff in the history
set autoread              " reload files (no local changes only)

set encoding=utf-8

set hidden                " allow buffer switching without saving
set diffopt+=iwhite       " Add ignorance of whitespace to diff

set nobackup              " do not keep backups after close
set nowritebackup         " do not keep a backup while working
set noswapfile            " don't keep swp files either

" file-specific indentation
au FileType go setl noet ts=4 sw=4 sts=4

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

syntax on                 " Switch on syntax highlighting.
set t_Co=256              " Fix colors in the terminal
set background=dark
colorscheme base16-paraiso

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set ttyfast                " usually automatic, needed in tmux
set number                 " line numbers
set numberwidth=5          " 3 digit line numbers don't get squashed
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set mousehide              " Hide the mouse pointer while typing
set scrolloff=5            " minimum lines to keep above and below cursor
set sidescrolloff=7
set sidescroll=1
set splitbelow             " splits that make more sense
set splitright

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set laststatus=2           " always show the status line
set ignorecase smartcase   " ignore case for searches without capital letters
set hlsearch               " highlight searches
set incsearch              " do incremental searching
set visualbell             " shut the fuck up
set cpoptions+=$           " in the change mode, show an $ at the end

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set formatoptions+=n       " support for numbered/bullet lists
set textwidth=80           " wrap at 80 chars by default
set colorcolumn=+1
set virtualedit=block      " allow virtual edit in visual block ..

set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j     " be smart about joining lines with comments
endif

" Change cursor shape in insert mode
"if exists('$TMUX')
"  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
" ---------------------------------------------------------------------------
"  Neocomplete
" ---------------------------------------------------------------------------

" ruby private/protected indentation
let g:ruby_indent_access_modifier_style = 'outdent'

" Enable Neocomplete
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 15
set completeopt+=menuone
set completeopt-=preview

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" gofmt style auto-format rust on save
let g:rustfmt_autosave = 1

" don't check handlebars with html tidy...
let g:syntastic_filetype_map = { "html.handlebars": "handlebars" }

" ---------------------------------------------------------------------------
"  Mappings
" ---------------------------------------------------------------------------

" Disable arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Easy block pasting with auto indentation
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=

" Copy/paste system buffer
nnoremap <leader>y "*y
nnoremap <leader>p "*p

" Blank lines without insert
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Switch from horizontal split to vertical split and vice versa
nnoremap <leader>- <C-w>t<C-w>H
nnoremap <leader>\ <C-w>t<C-w>K

" Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabnew<CR>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" split pane into new tab
nnoremap ts  <C-w>T

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" close current buffer with <leader>x
map <silent> <leader>x :bd<CR>

" show whitespace with <leader>s
set listchars=tab:——,trail:·,space:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" practical vim: use c-p, c-n with filtered command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" ----------------------------------------------------------------------------
" Airline
" ----------------------------------------------------------------------------

let g:airline_theme = 'powerlineish'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Enable airline tabline!
let g:airline#extensions#tabline#enabled = 1
" only show the tabline when we have more than one tab
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" flat separators, no arrows
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" disable the GUI close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
