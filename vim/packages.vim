let s:current_file = expand('<sfile>')
if !exists('*packages#reload')
  func! packages#reload() abort
    exec 'source ' . s:current_file
  endfunc
endif

command! -bar PackUpdate packadd minpac | call packages#reload() | redraw | call minpac#update()
command! -bar PackClean  packadd minpac | call packages#reload() | call minpac#clean()

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
call minpac#add('stephenway/postcss.vim')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('Shougo/vinarise.vim')
" Lint
call minpac#add('w0rp/ale')
" Completion
call minpac#add('Shougo/echodoc.vim')
if has('nvim')
  call minpac#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
endif
call minpac#add('slashmili/alchemist.vim')
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

call minpac#add('janko-m/vim-test')
call minpac#add('junegunn/vim-peekaboo')
" File finder
let g:loaded_netrwPlugin = 1 " unload netrw
call minpac#add('justinmk/vim-dirvish')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
" Git
call minpac#add('lambdalisue/gina.vim')
call minpac#add('airblade/vim-gitgutter')

call minpac#add('ludovicchabant/vim-gutentags')

