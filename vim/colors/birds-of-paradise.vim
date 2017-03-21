" Vim color file
" Author: Blaž Hrastnik
"
" Note:
" Original Birds of Paradise theme created by Joe Bergantine for Coda.
" Some tweaks included from the emacs version (https://github.com/jimeh/birds-of-paradise-plus-theme.el)
" But mostly me, recoding it from scratch.

" Bootstrap: 

hi clear
if exists("syntax_on") | syntax reset | endif
set background=dark
let g:colors_name = "birds-of-paradise"

" Palette: {{{

" setup palette dictionary
let s:birds = {}

let s:birds.foreground  = ["#e6e1c4", 188]
let s:birds.background  = ["#372725", 52]
let s:birds.background  = ["#452E2E", 52]
let s:birds.background2 = ["#372725", "NONE"]
let s:birds.background2 = ["#452E2E", "NONE"] " also #463433
let s:birds.selection   = ["#a40042", 125]
let s:birds.cursor      = ["#DBF5F3", 253]
let s:birds.cursor      = ["#865C38", 253]
let s:birds.line        = ["#493a35", 59]
"let s:birds.line = ["#654D4D", 52]
let s:birds.line = ["#513636", 59]
let s:birds.line = ["#4c3b3b", 59]
let s:birds.border      = ["#8f8475", 102]
"let s:birds.border = ["#654D4D", 59] " white-3
let s:birds.window      = ["#6a5d53", 59] " statusline (inactive)
let s:birds.comment     = ["#6b4e32", 59] " brown -> #865C38
let s:birds.comment     = ["#865C38", 95] " brown

let s:birds.red         = ["#ef5d32", 203] " magenta
let s:birds.ocra        = ["#efac32", 215]
let s:birds.yellow      = ["#d9d762", 185]
"let s:birds.green      = ["#889b4a", 107]
"let s:birds.green       = ["#49830c", 64] " old
let s:birds.blue        = ["#6c99bb", 67]
let s:birds.cyan        = ["#7daf9c", 109]
let s:birds.purple      = ["#8856d2", 98]
let s:birds.lpurple     = ["#BE73FD", 135]
let s:birds.cyan2       = ["#86b4bb", 109]

let s:birds.diff_green  = ["#8CFF8C", 120]
let s:birds.diff_red    = ["#FF7575", 210]
let s:birds.dblue       = ["#204a87", 23] " dblue (info text) #2c3956

let s:birds.error       = ["#f47868", 209]
let s:birds.todo        = ["#ffcd1c", 220]

" }}}
" Helpers: {{{

function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    let highlightString = 'hi ' . a:group . ' '

    " Settings for highlight group ctermfg & guifg
    if strlen(a:fg)
        if a:fg == 'fg'
            let highlightString .= 'guifg=fg ctermfg=fg '
        elseif a:fg == 'none'
            let highlightString .= 'guifg=NONE ctermfg=NONE '
        else
            let color = get(s:birds, a:fg)
            let highlightString .= 'guifg=' . color[0] . ' ctermfg=' . color[1] . ' '
        endif
    endif

    " Settings for highlight group termbg & guibg
    if a:0 >= 1 && strlen(a:1)
        if a:1 == 'bg'
            let highlightString .= 'guibg=bg ctermbg=bg '
        elseif a:1 == 'none'
          let highlightString .= 'guibg=NONE ctermbg=NONE '
        else
            let color = get(s:birds, a:1)
            let highlightString .= 'guibg=' . color[0] . ' ctermbg=' . color[1] . ' '
        endif
    endif

    " Settings for highlight group cterm & gui
    if a:0 >= 2 && strlen(a:2)
        let highlightString .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
    endif

    " Settings for highlight guisp
    if a:0 >= 3 && strlen(a:3)
        let color = get(s:birds, a:3)
        let highlightString .= 'guisp=#' . color[0] . ' '
    endif

    " echom highlightString

    execute highlightString
endfunction

"hi Normal ctermfg=188 ctermbg=NONE cterm=NONE guifg=#e6e1c4 guibg=#372725 gui=NONE
call s:HL('Normal', 'foreground', 'background2', 'none')

call s:HL('VertSplit',    'line',       'line',      'none')
"call s:HL('VertSplit',    'line',       'background',      'none')

call s:HL('Cursor',       'background', 'cursor',    'none') " vCursor, iCursor
call s:HL('Visual',       '',           'selection', 'none')

call s:HL('CursorLine',   '',           'line',      'none')
call s:HL('CursorColumn', '',           'line',      'none')
call s:HL('ColorColumn',  '',           'line',      'none')

call s:HL('Tabline',     'foreground', 'line',   'bold')
call s:HL('TablineFill', 'foreground', 'window', 'bold')
call s:HL('TablineSel',  '',           '',       'inverse')

" - Gutter
call s:HL('LineNr',       'border',     'line',      'none')
"call s:HL('LineNr',       'border',     'background',      'none')
" CursorLineNr
call s:HL('SignColumn',   'border',     'line',      'none')
call s:HL('FoldColumn',   'border',     'line',      'none')
"call s:HL('SignColumn',   'border',     'background',      'none')
"call s:HL('FoldColumn',   'border',     'background',      'none')
call s:HL('Folded',    'comment',  'background',     'none')

"call s:HL('MatchParen',   'window', '',   'inverse')
call s:HL('MatchParen',   'ocra', 'line',   'inverse')

call s:HL('StatusLine',   'foreground', 'line',   'bold')
call s:HL('StatusLineNC', 'foreground', 'window', 'none')

call s:HL('Directory', 'blue', '', 'none')

call s:HL('Title', 'foreground', '', 'bold')

call s:HL('ErrorMsg', 'red', 'none', 'bold')
call s:HL('WarningMsg', 'ocra', 'none')
call s:HL('ModeMsg', 'blue', 'none')
call s:HL('Question', 'blue', 'none')
" MoreMsg

" ctags tag
call s:HL('Tag',  'ocra', '')

" - Completion menu
call s:HL('Pmenu',    'border', 'line', 'none')
call s:HL('PmenuSel', '', 'selection', 'none')

call s:HL('Underlined', '', '', 'underline')

call s:HL('Search',    'background', 'yellow', 'none')
call s:HL('IncSearch', 'background', 'yellow', 'none')

" Tildes below buffer
call s:HL('NonText', 'comment', '', 'none')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:HL('SpecialKey', 'selection', '', 'none')

" - Diffs
call s:HL('DiffAdd', 'diff_green', 'line', 'bold')
call s:HL('DiffDelete', 'diff_red', 'line', '')
call s:HL('DiffChange', 'foreground', 'dblue', '')
call s:HL('DiffText', 'foreground', 'purple', 'bold')

call s:HL('DiffAdded', 'diff_green', '', 'bold')
call s:HL('DiffRemoved', 'diff_red', '', '')
call s:HL('DiffChanged', 'foreground', 'dblue', '')

" -----> Syntax
" start simple
call s:HL('Special', 'foreground', '', 'none')
"call s:HL('Special', 'ocra', '', 'none') TODO: simplify stuff by using special

" next up, comments
call s:HL('Comment', 'comment', '', 'italic')
" SpecialComment
call s:HL('Todo', 'yellow', 'line', 'italic')
call s:HL('Error', 'red', 'line')

call s:HL('Todo', 'todo', 'line', 'italic')
call s:HL('Error', 'error', 'line')

call s:HL('String', 'yellow', '', 'italic')

" --> Keywords
" generic statement
call s:HL('Statement',  'red', '', 'none')
" if, then, else, endif, switch, etc.
call s:HL('Conditional', 'red', '', 'none')
" sizeof, "+", "*", etc.
call s:HL('Operator',    'red', '', 'none')
" case, default, etc.
call s:HL('Label',       'yellow', '', 'none')
" Repeat (for, do, while, etc.)
" hi Repeat
" try, catch, throw
" hi Exception
" Any other keyword
call s:HL('Keyword',     'red', '', 'none')

" --> Functions and variable declarations
call s:HL('Identifier', 'red', '', 'none')
call s:HL('Function',   'ocra','', 'none')

" --> Preprocessor
"  generic
call s:HL('PreProc',    'red', '', 'none')
" Include
call s:HL('Define',     'red', '', 'none')
" Macro, PreCondit

" --> Constants
call s:HL('Constant',  'blue', '', 'none')
call s:HL('Character', 'blue', '', 'none')
call s:HL('Boolean',   'blue', '', 'none')

call s:HL('Number',    'blue', '', 'none')
call s:HL('Float',     'blue', '', 'none')

" --> Types
" generic
call s:HL('Type',        'ocra', '', 'none')
" static, register, volatile, etc
call s:HL('StorageClass', 'red', '', 'none')
" Structure, Typedef

" --> Ruby
"call s:HL('Delimiter', 'cyan', '', 'none') " TODO: ?

call s:HL('rubySymbol',           'blue',    '', 'none')
call s:HL('rubyConstant',         'ocra',    '', 'none')
call s:HL('rubyStringDelimiter',  'yellow',  '', 'italic')
call s:HL('rubyIdentifier',       'cyan',    '', 'none')
call s:HL('rubyPredefinedIdentifier', 'red', '', 'none')
call s:HL('rubyInterpolation', 'none', '', 'none') " TODO: remove (defaults to Delimiter => Special)
call s:HL('rubyInterpolationDelimiter', 'cyan', '', 'none')
call s:HL('rubyRegexp',           'purple',  '', 'none')
call s:HL('rubyRegexpDelimiter',  'purple',  '', 'none')
call s:HL('rubyRegexpSpecial',    'lpurple', '', 'none')
call s:HL('rubyEscape',           'blue',    '', 'none') " TODO: this also defaults to Special
call s:HL('rubyException',        'red',     '', 'none')

call s:HL('rubyRailsUserClass',   'foreground', '', 'none')
call s:HL('rubyRailsMethod',      'ocra',       '', 'none')

" --> Elixir
call s:HL('elixirStringDelimiter',        'yellow', '', 'italic')
call s:HL('elixirInterpolationDelimiter', 'cyan',   '', '')

" --> HTML
call s:HL('htmlTag',         'cyan2', '', '')
call s:HL('htmlEndTag',      'cyan2', '', '')
call s:HL('htmlTagName',     'cyan2', '', '')
call s:HL('htmlArg',         'cyan2', '', '')
call s:HL('htmlSpecialChar', 'blue',  '', '')
call s:HL('htmlSpecialTagName', 'ocra',  '', '')
call s:HL('jsFuncArgs', 'blue',  '', '')
call s:HL('jsFuncCall', 'ocra',  '', '')


" YAJS
call s:HL('javascriptImport', 'red',  '', '')
call s:HL('javascriptExport', 'red',  '', '')
call s:HL('javascriptIdentifier', 'blue',  '', '')
call s:HL('javascriptIdentifierName', 'blue',  '', '')
call s:HL('javascriptObjectLabel', 'ocra',  '', '')
call s:HL('javascriptBraces', 'foreground',  '', '')

" Typescript
call s:HL('typescriptBraces', 'foreground',  '', '')
call s:HL('typescriptEndColons', 'foreground',  '', '')

" YAML
call s:HL('yamlKey', 'ocra',  '', '')
call s:HL('yamlAnchor', 'cyan',  '', '')
call s:HL('yamlAlias', 'cyan',  '', '')
call s:HL('yamlDocumentHeader', 'yellow',  '', '')

" CSS
call s:HL('cssURL',           'cyan',       '', '')
call s:HL('cssColor',         'blue',       '', '')
call s:HL('cssPseudoClassId', 'ocra',       '', '')
call s:HL('cssClassName',     'ocra',       '', '')
call s:HL('cssValueLength',   'blue',       '', '')
call s:HL('cssCommonAttr',    'blue',       '', '')
call s:HL('cssUnitDecorators','red',       '', '')
call s:HL('cssProp','cyan',       '', '')
call s:HL('cssBraces',        'foreground', '', '')
