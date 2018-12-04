let s:current_file = expand('<sfile>')
if !exists('*packages#reload')
  func! packages#reload() abort
    exec 'source ' . s:current_file
  endfunc
endif

command! -bar PackUpdate packadd minpac | call packages#reload() | redraw | call minpac#update() | call minpac#status()
command! -bar PackClean  packadd minpac | call packages#reload() | call minpac#clean()
command! -bar PackStatus packadd minpac | call packages#reload() | call minpac#status()

if !exists('*minpac#init')
  finish
endif

call minpac#init({'verbose': 0})

" Colors
call minpac#add('archseer/colibri.vim', {'type': 'opt'})
"call minpac#add('whatyouhide/vim-gotham', {'type': 'opt'}) " gotham256 for 256 color terminals
call minpac#add('cocopon/colorswatch.vim')
" Languages
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('rust-lang/rust.vim')
call minpac#add('stephenway/postcss.vim')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('Shougo/vinarise.vim')
call minpac#add('jparise/vim-graphql')
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
" Lint
call minpac#add('w0rp/ale')
" Completion
call minpac#add('Shougo/echodoc.vim')
if has('nvim')
  call minpac#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
endif
call minpac#add('Shougo/neosnippet')
call minpac#add('honza/vim-snippets', {'type': 'opt'})
" Code manipulation
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-abolish') " keepcase when replacing stuff
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('machakann/vim-sandwich')
call minpac#add('Raimondi/delimitMate')
call minpac#add('mattn/emmet-vim')
call minpac#add('yangmillstheory/vim-snipe')
call minpac#add('machakann/vim-highlightedyank')

call minpac#add('janko-m/vim-test')
call minpac#add('junegunn/vim-peekaboo')
" File finder
call minpac#add('justinmk/vim-dirvish')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
" Git
call minpac#add('lambdalisue/gina.vim')
call minpac#add('airblade/vim-gitgutter')

call minpac#add('ludovicchabant/vim-gutentags')

