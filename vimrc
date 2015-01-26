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
Plugin 'vim-ruby/vim-ruby'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
Plugin 'wting/rust.vim'
Plugin 'bash-support.vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'Shougo/echodoc.vim'
if has('lua')
  Plugin 'Shougo/neocomplete.vim'
endif
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'

call vundle#end()
filetype plugin indent on

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible           " be iMproved, required
set history=1000           " keep some stuff in the history
set autoread               " reload files (no local changes only)

set encoding=utf-8
set fileencoding=utf-8

set hidden                " allow buffer switching without saving
set diffopt+=iwhite       " Add ignorance of whitespace to diff

" Golang tab settings
au FileType go setl noet ts=4 sw=4 sts=4

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

syntax on                 " Switch on syntax highlighting.
set t_Co=256              " Fix colors in the terminal
set background=dark
colorscheme base16-paraiso

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup                           " do not keep backups after close
set nowritebackup                      " do not keep a backup while working
set noswapfile                         " don't keep swp files either
set backupdir=$HOME/.vim/backup        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
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
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set hlsearch               " highlight searches
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

" ---------------------------------------------------------------------------
"  Neocomplete
" ---------------------------------------------------------------------------

" Enable Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:echodoc_enable_at_startup = 1
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

" ---------------------------------------------------------------------------
"  Mappings
" ---------------------------------------------------------------------------

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Easy block pasting with auto indentation
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" unicode symbols
let g:airline_theme = 'powerlineish'
let g:airline_symbols = {}
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

let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
