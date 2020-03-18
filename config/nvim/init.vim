" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------
let mapleader=" "
let maplocalleader="\\"
let g:vim_home = expand('<sfile>:p:h')

if !has('nvim') " load sensible neovim defaults on regular vim
  set encoding=utf-8
  silent! runtime sensible.vim
endif

" for some reason, using vim8 packages, these two won't be set to on
filetype plugin indent on
syntax on

runtime packages.vim
" for some reason the clipboard never got initialized
runtime autoload/provider/clipboard.vim
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
"set ch=2                   " command line height
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
set tags="~/.vim/tags"
" ---------------------------------------------------------------------------
"  Go to definition
" ---------------------------------------------------------------------------
" set tags="~/.vim/tags"
" let g:gutentags_cache_dir="~/.vim/tags"

" let g:gutentags_ctags_exclude=["node_modules","plugged","tmp","temp","log","vendor","**/db/migrate/*","bower_components","dist","build","coverage","spec","public","app/assets","*.json"]

" Enter is go to definition
nnoremap <CR> <C-]>
" In the quickfix window, <CR> is used to jump to the error under the cursor, undef
autocmd FileType qf nnoremap <buffer> <CR> <CR>
" same for vim type windows (command-history, terminal, etc.)
autocmd FileType vim nnoremap <buffer> <CR> <CR>
" ---------------------------------------------------------------------------
"  Completion / Snippets
" ---------------------------------------------------------------------------
let g:echodoc_enable_at_startup = 1
let g:delimitMate_expand_cr = 2
if has('nvim') " Use completion.
  set completeopt+=menuone
  set completeopt+=noselect
  set completeopt-=preview
  if has('patch-7.4.314') | set shortmess+=c | endif

  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  let g:ncm2#popup_delay = 80
  let g:ncm2#complete_delay = 10
  let g:ncm2#total_popup_limit = 20

  " TODO: neosnippet, maybe skip bufword

  let g:ncm2#filter = {'name':'substitute',
                    \ 'pattern': '[\(\s].*$',
                    \ 'replace': '',
                    \ 'key': 'word'}

  let g:endwise_no_mappings = 1 " don't override my map..
  function! s:smart_cr()
    " neosnippet || deoplete || delimitmate || vim-endwise
          "\ : pumvisible() ? deoplete#mappings#close_popup()
    return neosnippet#expandable_or_jumpable() ?
          \ neosnippet#mappings#expand_or_jump_impl()
          \ : pumvisible() ? "\<c-y>"
          \ : delimitMate#WithinEmptyPair() ? delimitMate#ExpandReturn()
          \ : "\<CR>" . EndwiseDiscretionary()
  endfunction
  inoremap <expr> <CR> <SID>smart_cr()
  inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
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
  "set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory= g:vim_home .'/pack/minpac/opt/vim-snippets/snippets'

" -- Language servers -------------------------------------------------------
let g:lsp_diagnostics_enabled = 0
"let g:lsp_async_completion = 1
let g:lsp_signs_error   = {'text': '●'}
let g:lsp_signs_warning = {'text': '●'}
let g:lsp_signs_hint    = {'text': '●'}
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
highlight link LspWarningHighlight Todo
highlight link LspInformationHighlight Todo
highlight link LspErrorHighlight WarningMsg
augroup lsp
  au!
  if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
          \ 'whitelist': ['typescript'],
          \ })
  endif
  au User lsp_setup call lsp#register_server({
        \ 'name': 'elixir-ls',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, '~/src/elixir-ls/language_server.sh']},
        \ 'whitelist': ['elixir', 'eelixir'],
        \ 'workspace_config': {'elixirLS': {'dialyzerEnabled': v:false}},
        \ })
  if executable('vls')
  au User lsp_setup call lsp#register_server({
        \   'name': 'vue-language-server',
        \   'cmd': {server_info->['vls']},
        \   'whitelist': ['vue'],
        \   'workspace_config': {'vetur': {'validation': {'style': v:false}}},
        \ })
  end
  if executable('ra_lsp_server')
      au User lsp_setup call lsp#register_server({
        \ 'name': 'ra_lsp_server',
        \ 'cmd': {server_info->['ra_lsp_server']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
        \ 'whitelist': ['rust'],
        \ })
  endif
  " if executable('rls')
  "     au User lsp_setup call lsp#register_server({
  "       \ 'name': 'rls',
  "       \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
  "       \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
  "       \ 'whitelist': ['rust'],
  "       \ })
  
  " endif
augroup END

nnoremap <leader>r :LspReferences<CR>
nnoremap <leader>d :LspPeekDefinition<CR>
nnoremap <leader>m :LspDocumentSymbol<CR>

" -- Linting ----------------------------------------------------------------
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters = {'elixir': ['credo'], 'vue': ['eslint']} " 'tsserver', 
let g:ale_fixers = {'vue': ['eslint'], 'javascript': ['eslint', 'tslint']}
let g:ale_linter_aliases = {'vue': 'typescript'}
let g:ale_fix_on_save = 1
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"
let g:ale_virtualtext_cursor = 1
" highlight link ALEWarningSign Todo
" highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
" ---------------------------------------------------------------------------
"  Filetype/Plugin-specific config
" ---------------------------------------------------------------------------
" ruby private/protected indentation
let g:ruby_indent_access_modifier_style = 'outdent'
let ruby_operators = 1 " highlight operators

let g:rustfmt_autosave = 1

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

let g:highlightedyank_highlight_duration = 500
" ---------------------------------------------------------------------------
"  Mappings
" ---------------------------------------------------------------------------
" Dump ex mode for formatting
nnoremap Q gqip
vnoremap Q gq

" Steal hauleth's file closing mappings
nnoremap ZS :wa<CR>
nnoremap ZA :qa<CR>
nnoremap ZX :cq<CR>

" Save the file (if it has been modified)
nnoremap <silent> <leader>w :up<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Copy/paste system buffer
noremap <leader>y "+y
noremap <leader>p "+p

" Switch from horizontal split to vertical split and vice versa
nnoremap <leader>- <C-w>t<C-w>H
nnoremap <leader>\ <C-w>t<C-w>K

noremap <leader>v <C-w>v

" close current buffer with <leader>x
noremap <silent> <leader>x :bd<CR>
noremap <silent> <leader>c :q<CR>

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
    return 'NORMAL'
  elseif a:mode == 'i'
    return 'INSERT'
  elseif a:mode == 'R'
    return 'REPLACE'
  elseif a:mode == 't'
    return 'TERMINAL'
  elseif a:mode =~# '\v(v|V||s|S|)'
    return a:mode == 'v' ? 'VISUAL' : a:mode == 'V' ? 'V-LINE' : 'V-BLOCK'
  else
    return a:mode
  endif
endfunction

"hi StatusError ctermbg=17 ctermfg=209 guibg=#F22C86 guifg=#281733
hi StatusError ctermbg=17 ctermfg=209 guifg=#f47868 guibg=#281733
hi StatusWarning ctermbg=17 ctermfg=209 guifg=#ffcd1c guibg=#281733
hi StatusOk ctermbg=17 ctermfg=209 guifg=#ffffff guibg=#281733
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
  endfunction
function! Status(winnr)
  let active = a:winnr == winnr() || winnr('$') == 1
  let status = ''
  if active != 0
    let status .= ' %{StatusHighlight(mode())} '
  endif
  let status .= ' %{fnamemodify(expand("%"), ":~:.")}%w%q%h%r%<%m '
  let status .= '%{&paste?"[paste]":""}'

  if &filetype != 'netrw' && &filetype != 'undotree'
    let status .= '%='
    if active != 0 " only show lint information in the active window
      let l:counts = ale#statusline#Count(bufnr(''))

      if l:counts.total == 0
        let status .=  '%#StatusOk#⬥ ok%* '
      else
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        if l:all_errors > 0
          let status .=  '%#StatusError#'
          let status .= printf('⨉ %d', all_errors)
          let status .= '%* '
        endif
        if l:all_non_errors > 0
          let status .=  '%#StatusWarning#'
          let status .= printf('● %d', all_non_errors)
          let status .= '%* '
        endif
      endif
    endif
    if &fenc != 'utf-8'
      let status .=  ' %{&fileencoding} |'
    endif
    let status .=  ' %{&filetype}  %l:%c '
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
  autocmd BufRead,BufNewFile *.lalrpop setfiletype rust
augroup END

augroup align_windows
  au!
  au VimResized * wincmd =
augroup END

" -- Abbreviations ----------------------------------------------------------
iabbrev jsut    just
iabbrev teh     the
iabbrev recieve receive
iabbrev ipnut   input
iabbrev copmany company
