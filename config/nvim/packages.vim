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

" needs to load before rust.vim
call minpac#add('jiangmiao/auto-pairs')
" Languages
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('rust-lang/rust.vim')
call minpac#add('stephenway/postcss.vim')
let g:polyglot_disabled = ['org']
call minpac#add('sheerun/vim-polyglot')
call minpac#add('Shougo/vinarise.vim')
" call minpac#add('jceb/vim-orgmode')
" LSP
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
" Lint
call minpac#add('w0rp/ale')
" Completion
call minpac#add('ncm2/ncm2')
call minpac#add('roxma/nvim-yarp')
call minpac#add('ncm2/float-preview.nvim')
call minpac#add('ncm2/ncm2-bufword')
call minpac#add('ncm2/ncm2-path')
call minpac#add('ncm2/ncm2-vim-lsp')
call minpac#add('ncm2/ncm2-html-subscope')
call minpac#add('ncm2/ncm2-markdown-subscope')
" Snippets
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets', {'type': 'opt'})
call minpac#add('ncm2/ncm2-ultisnips')
" call minpac#add('ludovicchabant/vim-gutentags')
" Code manipulation
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-abolish') " keepcase when replacing stuff
call minpac#add('tpope/vim-commentary')
" call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('machakann/vim-sandwich')
" call minpac#add('Raimondi/delimitMate')
call minpac#add('mattn/emmet-vim')
"call minpac#add('yangmillstheory/vim-snipe')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('andymass/vim-matchup')

call minpac#add('janko-m/vim-test')
call minpac#add('junegunn/vim-peekaboo')
" File finder
call minpac#add('justinmk/vim-dirvish')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
" Git
call minpac#add('lambdalisue/gina.vim')
call minpac#add('airblade/vim-gitgutter')

