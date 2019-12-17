setlocal omnifunc=lsp#complete
setlocal keywordprg=:LspHover
nnoremap <buffer> <C-]> :LspDefinition<CR>
nnoremap <buffer> <CR> :LspDefinition<CR>
