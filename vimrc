" ---------------------------------------------------------------------------
" vim-plug
" ---------------------------------------------------------------------------

set nocompatible
call plug#begin('~/.vim/plugged')

"Plug 'godlygeek/csapprox'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
" languages
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'nsf/gocode', {'rtp': 'vim/', 'for': 'go'}
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'stephenway/postcss.vim'
Plug 'slashmili/alchemist.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/vinarise.vim'

Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish' " keepcase when replacing stuff
"Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
Plug 'machakann/vim-sandwich'

Plug 'osyo-manga/vim-over'
Plug 'junegunn/vim-peekaboo'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'lambdalisue/gina.vim'

Plug 'ludovicchabant/vim-gutentags'
"setting tags directory
set tags="~/.vim/tags"
"set tags=tags
"set one location for tags
let g:gutentags_cache_dir="~/.vim/tags"

"set ctags executable for go
"let g:gutentags_ctags_executable_go="$GOPATH/bin/gotags"

"set list of directories to exclude when generating tags
let g:gutentags_ctags_exclude=["node_modules","plugged","tmp","temp","log","vendor","**/db/migrate/*","bower_components","dist","build","coverage","spec","public","app/assets","*.json"]

" Enter is go to definition (ctags)
nnoremap <CR> <C-]>
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd FileType qf nnoremap <buffer> <CR> <CR>
" fix it for terminals as well
autocmd TermOpen * nnoremap <buffer> <CR> <CR>

" alchemist should also bind to enter.
let g:alchemist_tag_map = '<CR>'
let g:alchemist_tag_stack_map = '<C-T>'

runtime macros/matchit.vim

call plug#end()

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------
let mapleader=" "
let maplocalleader="\\"

set history=1000          " keep some stuff in the history
set autoread              " reload files (no local changes only)

set encoding=utf-8

set hidden                " allow buffer switching without saving
set diffopt+=iwhite       " Add ignorance of whitespace to diff
set diffopt+=vertical     " Allways diff vertically

set nobackup              " do not keep backups after close
set nowritebackup         " do not keep a backup while working
set noswapfile            " don't keep swp files either

if has('nvim')
  "set clipboard+=unnamedplus " fix my nvim <leader>y action
endif

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

syntax on                 " Switch on syntax highlighting.
"set t_Co=256             " Fix colors in the terminal
set background=dark
colorscheme base16-paraiso

if has('nvim')
  set termguicolors
  "colors birds-of-paradise
  colors colibri
endif
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
set synmaxcol=200          " Boost performance of rendering long lines

" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   au WinLeave * setlocal nocursorline
" augroup END

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
if exists('&belloff')
  set belloff=all          " never ring the bell for any reason
endif
set cpoptions+=$           " in the change mode, show an $ at the end

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set smartindent            " be smart about it
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent          " when wrapping, indent the lines

  set breakindentopt=sbr
endif
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set shiftround             " Round indent shift to multiple of shiftwidth
set tabstop=4
set expandtab              " expand tabs to spaces
set formatoptions+=n       " support for numbered/bullet lists
set textwidth=80           " wrap at 80 chars by default
set colorcolumn=+1
set virtualedit=block      " allow virtual edit in visual block ..
set nojoinspaces           " Use one space, not two, after punctuation.

set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j     " be smart about joining lines with comments
endif

" Change cursor shape in insert mode
if has('nvim')
  "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif
" ---------------------------------------------------------------------------
"  Neocomplete
" ---------------------------------------------------------------------------

" ruby private/protected indentation
let g:ruby_indent_access_modifier_style = 'outdent'
" highlight operators
let ruby_operators = 1

set noshowmode " it tampers with echodoc.
let g:echodoc_enable_at_startup = 1
if has('nvim')
  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
  "inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neosnippet#expandable_or_jumpable() ?
          \ neosnippet#mappings#expand_or_jump_impl()
          \ : pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
  endfunction
endif
set completeopt+=menuone
set completeopt-=preview

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers. (neosnippet)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

" vim-go
au FileType go setl noet ts=4 sw=4 sts=4
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" gofmt style auto-format rust on save
let g:rustfmt_autosave = 1

"let g:syntastic_shell                    = '/bin/zsh'
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list            = 2 " if 1, :lclose
"let g:syntastic_check_on_open            = 1
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_ruby_checkers = ["mri", "reek"]
"
" Ale
let g:ale_statusline_format = ['⨉ %d', '● %d', '']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_open_list = 0
let g:ale_linters = {'elixir': ['dogma']}

let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"

" vinarise
let g:vinarise_enable_auto_detect = 1
" Enable with -b option
autocmd BufReadPre   *.bin let &binary =1
autocmd BufReadPost  * if &binary | Vinarise
autocmd BufWritePre  * if &binary | Vinarise | endif
autocmd BufWritePost * if &binary | Vinarise

" vim-test

let test#strategy = "neovim"
let test#filename_modifier = ":p"
"function! s:cat(filename) abort
"  return system('cat '.a:filename)
"endfunction
"function! VagrantTransform(cmd) abort
"  return 'vagrant ssh --command '.shellescape('cd /vagrant; '.a:cmd)
"endfunction
"
"let g:test#custom_transformations = {'vagrant': function('VagrantTransform')}
"let g:test#transformation = 'vagrant'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
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


" Make arrow keys work properly in popup
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<NOP>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<NOP>"

nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Save the file (if it has been modified)
nnoremap <leader>w :up<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Easy block pasting with auto indentation
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=

" Copy/paste system buffer
noremap <leader>y "*y
noremap <leader>p "*p

" Blank lines without insert
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Switch from horizontal split to vertical split and vice versa
nnoremap <leader>- <C-w>t<C-w>H
nnoremap <leader>\ <C-w>t<C-w>K

noremap <leader>v <C-w>v

" close current buffer with <leader>x
map <silent> <leader>x :bd<CR>

" show whitespace with <leader>s
set listchars=tab:——,trail:·,eol:$
if has('patch-7.4.710')
  " show normal spaces too if possible
  set listchars+=space:·
endif
nmap <silent> <leader>s :set nolist!<CR>

" practical vim: use c-p, c-n with filtered command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Write with sudo
cmap w!! w !sudo tee > /dev/null %

" Shortcut for emmet
imap <c-e> <c-y>,

" toggle highlighting
" nnoremap <silent> <leader>h :set invhlsearch<CR>-1-1
nnoremap <silent> <leader>h :noh<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <C-p> :ProjectFiles<CR>

nnoremap <Leader>b :Buffers<CR>
" Switch buffers
nnoremap <Leader>f :ProjectFiles<CR>
nnoremap <Leader>e :History<CR>
"nnoremap <Leader>y :Lines<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Customize fzf colors to match your color scheme

" these colors are for dark
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  let g:fzf_nvim_statusline = 0
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Default peekaboo window
let g:peekaboo_window = 'vertical botright 60new'

let g:vue_disable_pre_processors=1

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------

function! StatusHighlight(mode)
    if a:mode == 'n' || a:mode == 'c'
        hi StatusMode ctermbg=148 ctermfg=22 term=bold cterm=bold guifg=#080808 guibg=#ffffff
        return 'NORMAL'

    elseif a:mode == 'i'
        hi StatusMode ctermbg=231 ctermfg=23 term=bold cterm=bold guifg=#005f5f guibg=#afd700
        return 'INSERT'

    elseif a:mode == 'R' || a:mode == 't'
        hi StatusMode ctermbg=160 ctermfg=231 term=bold cterm=bold guifg=#ffffff guibg=#d70000
        return a:mode == 'R' ? 'REPLACE' : 'TERMINAL' 

      elseif a:mode =~# '\v(v|V||s|S|)'
        hi StatusMode ctermbg=208 ctermfg=88 term=bold cterm=bold guifg=#080808 guibg=#ffaf00
        return a:mode == 'v' ? 'VISUAL' : a:mode == 'V' ? 'V-LINE' : 'V-BLOCK'

    else
        return a:mode
    endif
endfunction

function! Status(winnr)
  	let active = a:winnr == winnr() || winnr('$') == 1
    let status = ''
    if active != 0
      let status .= '%#StatusMode# %{StatusHighlight(mode())} %*'
    endif
    let status .= ' %{fnamemodify(expand(''%''), '':~:.'')}%w%q%h%r%<%m '

    let status .= '%{&paste?''[paste]'':''''}'

    if &filetype != 'netrw' && &filetype != 'undotree'
        let status .= '%=' 
        if active != 0
          " we can't wrap it in %{} because that kills the colors, but if we
          " don't, it will return the data for the active window. So, don't
          " display it on other windows.
          "let status .= '%{SyntasticStatuslineFlag()}'
          let status .= '%#error#%{ALEGetStatusLine()}%*'
        endif
        let status .=  ' %{&fileencoding} |'
                    \  .' %{&filetype} '
                    \  .' %l:%c '
    endif

    return status
endfunction

function! StatusUpdate()
    for winnr in range(1, winnr('$'))
        call setwinvar(winnr, '&statusline', '%!Status(' . winnr . ')')
    endfor
endfunction

autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call StatusUpdate()

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A

" ----------------------------------------------------------------------------
" vim-sandwich
" ----------------------------------------------------------------------------
"
" closest surround
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

" in middle (of)
" {'_'  '.' ',' '/' '-')
xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

xmap i_ im_
xmap a_ im_
omap i_ im_
omap a_ am_

" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" ----------------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------------

" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
function! Preserve(command)
  " Save search history and cursor position
  let save_search = @/
  let save_pos = getpos('.')

  " Run the command
  execute a:command

  " Restore search and position
  let @/ = save_search
  call setpos('.', save_pos)
endfunction

function! StripTrailingWhitespace()
  call Preserve("%s/\\s\\+$//e")
endfunction

nmap _$ :call StripTrailingWhitespace()<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --vimgrep'
endif

au filetype mail setl tw=72
au filetype mail setl fo=aw

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END
