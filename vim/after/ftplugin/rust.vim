compiler cargo

setlocal iskeyword+=!
setlocal formatprg=rustfmt\ --write-mode=display
let g:rustfmt_autosave = 1

setlocal omnifunc=lsp#complete
setlocal keywordprg=:LspHover
nnoremap <buffer> <C-]> :LspDefinition<CR>
nnoremap <buffer> <CR> :LspDefinition<CR>
