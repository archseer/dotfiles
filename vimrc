" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------
let mapleader=" "
let g:vim_home = expand('<sfile>:p:h')

if !has('nvim') " load sensible neovim defaults on regular vim
  set encoding=utf-8
  silent! runtime sensible.vim
endif

" for some reason, using vim8 packages, these two won't be set to on
filetype plugin indent on
syntax on

runtime packages.vim
let g:loaded_netrwPlugin = 1 " unload netrw, we use dirvish

set nobackup              " do not keep backups
set noswapfile            " don't keep swp files either
set undofile

" -- Colors / Theme ---------------------------------------------------------
set background=dark

if has('termguicolors')
  set termguicolors
  colors colibri
else
  colors base16-paraiso
endif

"  -- UI --------------------------------------------------------------------
set title
set ch=2                   " command line height
set hidden                 " allow buffer switching without saving
set lazyredraw             " no redraws in macros
set number                 " line numbers
set numberwidth=5          " 3 digit line numbers don't get squashed
set wildmode=list:longest,full
" Ignore all automatic files and folders
set wildignore=*.o,*~,*/.git,*/tmp/*,*/node_modules/*,*/_build/*,*/deps/*,*/target/*
set fileignorecase
set shortmess+=aAI         " shorten messages
set report=0               " tell us about changes
set mousehide              " Hide the mouse pointer while typing
set nostartofline          " don't jump to the start of line when scrolling
set scrolloff=5            " minimum lines to keep above and below cursor
set sidescrolloff=7
set sidescroll=1
set splitbelow splitright  " splits that make more sense
set switchbuf=useopen      " When buffer already open, jump to that window
set diffopt+=iwhite        " Add ignorance of whitespace to diff
set diffopt+=vertical      " Allways diff vertically
set synmaxcol=200          " Boost performance of rendering long lines
set guicursor=

" -- Search -----------------------------------------------------------------
set ignorecase smartcase   " ignore case for searches without capital letters
if executable('rg')        " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
" toggle search highlighting
nnoremap <silent> <leader>h :noh<cr>

" -- Visual Cues ------------------------------------------------------------
set showmatch matchtime=2  " show matching brackets/braces (2*1/10 sec)
set cpoptions+=$           " in the change mode, show an $ at the end
if has("nvim")
  set inccommand=nosplit   " live substitution preview
end
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent          " when wrapping, indent the lines
  set breakindentopt=sbr
endif
set fillchars=diff:⣿,vert:│,fold:·
" show whitespace with <leader>s
set listchars=tab:——,trail:·,eol:$
"set listchars+=extends:›,precedes:‹,nbsp:␣
if has('patch-7.4.710')    " show normal spaces too if possible
  set listchars+=space:·
endif
nnoremap <silent> <leader>s :set nolist!<CR>

" -- Text Formatting --------------------------------------------------------
" Don't mess with 'tabstop', with 'expandtab' it isn't used.
" Instead set softtabstop=-1, then 'shiftwidth' is used.
set expandtab shiftwidth=2 softtabstop=-1
set shiftround             " Round indent shift to multiple of shiftwidth
set textwidth=80           " wrap at 80 chars by default
set colorcolumn=+1
set virtualedit=block      " allow virtual edit in visual block ..
set nojoinspaces           " Use one space, not two, after punctuation.
set linebreak
set nowrap                 " do not wrap lines
set formatoptions+=rno1l   " support for numbered/bullet lists, etc.
" ---------------------------------------------------------------------------
"  Gutentags / go to definition
" ---------------------------------------------------------------------------
set tags="~/.vim/tags"
let g:gutentags_cache_dir="~/.vim/tags"

let g:gutentags_ctags_exclude=["node_modules","plugged","tmp","temp","log","vendor","**/db/migrate/*","bower_components","dist","build","coverage","spec","public","app/assets","*.json"]
"let g:gutentags_ctags_executable_go="$GOPATH/bin/gotags"

" Enter is go to definition (ctags)
nnoremap <CR> <C-]>
" In the quickfix window, <CR> is used to jump to the error under the cursor, undef
autocmd FileType qf nnoremap <buffer> <CR> <CR>
" same for vim type windows (command-history, terminal, etc.)
autocmd FileType vim nnoremap <buffer> <CR> <CR>

" alchemist should also bind to enter.
let g:alchemist_tag_map = '<CR>'
let g:alchemist_tag_stack_map = '<C-T>'
" ---------------------------------------------------------------------------
"  Completion / Snippets
" ---------------------------------------------------------------------------
let g:echodoc_enable_at_startup = 1
let g:delimitMate_expand_cr = 2
if has('nvim') " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  set completeopt+=menuone
  set completeopt-=noselect
  set completeopt-=preview
  if has('patch-7.4.314') | set shortmess+=c | endif

  let g:endwise_no_mappings = 1 " don't override my map..
  function! s:smart_cr()
    " neosnippet || deoplete || delimitmate || vim-endwise
    return neosnippet#expandable_or_jumpable() ?
          \ neosnippet#mappings#expand_or_jump_impl()
          \ : pumvisible() ? deoplete#mappings#close_popup()
          \ : delimitMate#WithinEmptyPair() ? delimitMate#ExpandReturn()
          \ : "\<CR>" . EndwiseDiscretionary()
  endfunction
  inoremap <expr> <CR> <SID>smart_cr()
endif
" neosnippet mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
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

let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory= g:vim_home .'/pack/minpac/opt/vim-snippets/snippets'

" vim-lsp & deoplete settings
let g:deoplete#max_list = 20
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#skip_chars = ["(", ")"]

" use lsp's omni for these
let g:deoplete#sources = {
      \  'elixir': ['omni'],
      \  'vue': ['omni'],
      \  'typescript': ['omni'],
      \}

"let g:deoplete#omni#functions = {'_': 'lsp#complete'}

let g:deoplete#omni#input_patterns = {
      \   'ruby': ['\w+', '[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
      \   'elixir': ['\w+', '[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
      \   'javascript': ['\w+', '[^. *\t]\.\w*'],
      \   'typescript': ['\w+', '[^. *\t]\.\w*'],
      \ }

augroup deoplete
  au!
  au VimEnter *
    \ call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_auto_delimiter',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
    \ ])
    \ call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length'])
augroup END

let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error   = {'text': '●'}
let g:lsp_signs_warning = {'text': '●'}
let g:lsp_signs_hint    = {'text': '●'}
augroup lsp
  au!
  if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
          \ 'whitelist': ['typescript''vue'],
          \ })
  endif
  au User lsp_setup call lsp#register_server({
        \ 'name': 'elixir-ls',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, '~/src/elixir-ls/language_server.sh']},
        \ 'whitelist': ['elixir', 'eelixir'],
        \ })
  if executable('vls')
  au User lsp_setup call lsp#register_server({
        \   'name': 'vue-language-server',
        \   'cmd': {server_info->['vls']},
        \   'whitelist': ['vue'],
        \ })
  end
augroup END

nnoremap <leader>r :LspReferences<CR>
nnoremap <leader>m :LspDocumentSymbol<CR>
" ---------------------------------------------------------------------------
"  Filetype/Plugin-specific config
" ---------------------------------------------------------------------------
" vim-go
au FileType go setl noet ts=4 sw=4 sts=4
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" auto-format rust on save
let g:rustfmt_autosave = 1

" ruby private/protected indentation
let g:ruby_indent_access_modifier_style = 'outdent'
let ruby_operators = 1 " highlight operators

let g:vue_disable_pre_processors=1

" Ale
let g:ale_statusline_format = ['⨉ %d', '● %d', '⬥ ok']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {'elixir': ['credo'], 'vue': ['tsserver', 'eslint']}
let g:ale_fixers = {'vue': ['eslint'], 'javascript': ['eslint', 'tslint']}
let g:ale_linter_aliases = {'vue': 'typescript'}
let g:ale_fix_on_save = 1
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"

" vinarise
let g:vinarise_enable_auto_detect = 1
" Enable with -b option
augroup vinariseAuto
  autocmd!
  autocmd BufReadPre   *.bin let &binary =1
  autocmd BufReadPost  * if &binary | Vinarise | endif
augroup END

au filetype mail setl tw=72 fo=aw

augroup postcss
  autocmd!
  autocmd BufNewFile,BufRead *.css set filetype=postcss
augroup END

" vim-gitgutter
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_removed = '▖'
let g:gitgutter_sign_removed_first_line = '▘'
let g:gitgutter_sign_modified = '▐'
let g:gitgutter_sign_modified_removed = '▞'

" vim-test
let test#filename_modifier = ":p"
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>

" Default peekaboo window
let g:peekaboo_window = 'vertical botright 60new'
" ---------------------------------------------------------------------------
"  Mappings
" ---------------------------------------------------------------------------
" Dump ex mode for formatting
nnoremap Q gqip
vnoremap Q gq

" Save the file (if it has been modified)
nnoremap <silent> <leader>w :up<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Easy block pasting with auto indentation
nnoremap p p'[v']=
nnoremap P P'[v']=
" Copy/paste system buffer
noremap <leader>y "*y
noremap <leader>p "*p

" Blank lines without insert
"nnoremap <leader>o o<Esc>
"nnoremap <leader>O O<Esc>

" Switch from horizontal split to vertical split and vice versa
nnoremap <leader>- <C-w>t<C-w>H
nnoremap <leader>\ <C-w>t<C-w>K

noremap <leader>v <C-w>v

" close current buffer with <leader>x
noremap <silent> <leader>x :bd<CR>

" practical vim: use c-p, c-n with filtered command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Write with sudo
cmap w!! w !sudo tee > /dev/null %

" Shortcut for emmet
imap <c-e> <c-y>,

" ?il | inner line
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -- fzf ---------------------------------------------------------------------
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :ProjectFiles<CR>
nnoremap <Leader>e :History<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Customize fzf statusline
autocmd! User FzfStatusLine setlocal statusline=%#StatusLine#\ >\ fzf

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
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

" -- vim-sandwich ------------------------------------------------------------
xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)
" in middle (of) {'_'  '.' ',' '/' '-')
xmap i_ im_
xmap a_ im_
omap i_ im_
omap a_ am_
" ----------------------------------------------------------------------------
" Statusline
" ----------------------------------------------------------------------------
function! StatusHighlight(mode)
  if a:mode == 'n' || a:mode == 'c'
    hi StatusMode ctermbg=148 ctermfg=22 term=bold cterm=bold guifg=#080808 guibg=#ffffff
    return 'NORMAL'
  elseif a:mode == 'i'
    hi StatusMode ctermbg=231 ctermfg=23 term=bold cterm=bold guifg=#005f5f guibg=#9FF28F
    return 'INSERT'
  elseif a:mode == 'R'
    hi StatusMode ctermbg=160 ctermfg=231 term=bold cterm=bold guifg=#740000 guibg=#f47868
    return 'REPLACE'
  elseif a:mode == 't'
    hi StatusMode ctermbg=160 ctermfg=231 term=bold cterm=bold guifg=#005f5f guibg=#00CCCC
    return 'TERMINAL'
  elseif a:mode =~# '\v(v|V||s|S|)'
    hi StatusMode ctermbg=208 ctermfg=88 term=bold cterm=bold guifg=#7f3a00 guibg=#efba5d
    return a:mode == 'v' ? 'VISUAL' : a:mode == 'V' ? 'V-LINE' : 'V-BLOCK'
  else
    return a:mode
  endif
endfunction

"hi StatusError ctermbg=17 ctermfg=209 guibg=#F22C86 guifg=#281733
hi StatusError ctermbg=17 ctermfg=209 guifg=#f47868 guibg=#281733
hi StatusOk ctermbg=17 ctermfg=209 guifg=#ffffff guibg=#281733
function! Status(winnr)
  let active = a:winnr == winnr() || winnr('$') == 1
  let status = ''
  if active != 0
    let status .= '%#StatusMode# %{StatusHighlight(mode())} %*'
  endif
  let status .= ' %{fnamemodify(expand("%"), ":~:.")}%w%q%h%r%<%m '
  let status .= '%{&paste?"[paste]":""}'

  if &filetype != 'netrw' && &filetype != 'undotree'
    let status .= '%='
    if active != 0 " only show lint information in the active window
      let l:counts = ale#statusline#Count(bufnr(''))
      let status .= l:counts.total == 0 ? '%#StatusOk#' : '%#StatusError#'
      let status .= '%{ALEGetStatusLine()}%* '
    endif
    let status .=  ' %{&fileencoding} | %{&filetype}  %l:%c '
  endif
  return status
endfunction

function! StatusUpdate()
  for winnr in range(1, winnr('$'))
    call setwinvar(winnr, '&statusline', '%!Status(' . winnr . ')')
  endfor
endfunction

set noshowmode " we show it in the statusline
augroup status-update
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call StatusUpdate()
augroup END
" ----------------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------------
function! Preserve(cmd)
  let _s = @/ | let _pos = getpos('.') " Save search history and cursor position
  execute a:cmd
  let @/ = _s | call setpos('.', _pos) " Restore search and position
endfunction

nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" HL | Find out syntax group
function! s:hl()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

augroup vimrcEx
  autocmd!
  " Auto create directories for new files.
  au BufWritePre,FileWritePre * call mkdir(expand('<afile>:p:h'), 'p')

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql
augroup END

augroup align_windows
  au!
  au VimResized * wincmd =
augroup END

" -- Abbreviations ----------------------------------------------------------
iabbrev jsut    just
iabbrev teh     the
iabbrev recieve receive
