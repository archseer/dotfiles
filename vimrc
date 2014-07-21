" ---------------------------------------------------------------------------
" Vundle
" ---------------------------------------------------------------------------

set nocompatible
filetype off                " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'godlygeek/csapprox'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'bash-support.vim'
Plugin 'terryma/vim-multiple-cursors'

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
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set mousehide              " Hide the mouse pointer while typing
set scrolloff=8            " minimum lines to keep above and below cursor

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
set virtualedit=block      " allow virtual edit in visual block ..

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

let NERDTreeShowBookmarks=1  " Show the bookmarks table on startup
let NERDTreeMinimalUI=1      " Get rid of the extra cruft

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$' ]

" ---------------------------------------------------------------------------
"  Mappings
" ---------------------------------------------------------------------------

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
