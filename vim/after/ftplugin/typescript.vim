let g:vue_disable_pre_processors=1

setlocal omnifunc=lsp#complete
setlocal keywordprg=:LspHover
nnoremap <buffer> <C-]> :LspDefinition<CR>
nnoremap <buffer> <CR> :LspDefinition<CR>
