" sensible.vim {{{

" may affect performance: https://github.com/tpope/vim-sensible/issues/57
" let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
" let &showbreak="\u21aa" " precedes line wrap
set listchars=tab:>\ ,trail:-,nbsp:+

if s:is_cygwin || !empty($TMUX)
  " Mode-dependent cursor   https://code.google.com/p/mintty/wiki/Tips
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

"transient dirs
let s:dir = '~/.local/share/vim'
let &directory = expand(s:dir, 1).'/swap//,'.&directory
if has("persistent_undo")
  let &undodir = expand(s:dir, 1).'/undo//,'.&undodir
endif

set ttimeout
set ttimeoutlen=100
set backspace=eol,start,indent
set wildmenu
set display+=lastline
set viminfo^=!
set sessionoptions-=options

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif
setglobal tags-=./tags tags-=./tags; tags^=./tags;

set autoindent  " Note: 'smartindent' is deprecated by 'cindent' and 'indentexpr'.
set complete-=i " Don't scan includes (tags file is more performant).
set smarttab    " Use 'shiftwidth' when using <Tab> in front of a line.

set incsearch
set mouse=a     " Enable mouse usage (all modes)
set hlsearch    " highlight search matches

set autoread

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set nrformats-=octal
set laststatus=2
set ruler
set history=10000

if !s:plugins
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif
  filetype plugin indent on
endif

" }}} sensible.vim
