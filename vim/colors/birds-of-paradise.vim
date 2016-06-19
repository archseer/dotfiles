" Vim color file
" Converted from Textmate theme Birds of Paradise using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "birds-of-paradise"

" }}}
" Palette: {{{

" setup palette dictionary
let s:birds = {}

let s:birds.foreground = ["#e6e1c4", 188]
let s:birds.background = ["#372725", 52]
let s:birds.background2 = ["#372725", "NONE"]
let s:birds.selection = ["#a40042", 125]
let s:birds.cursor = ["#DBF5F3", 253]
let s:birds.line = ["#493a35", 59]
let s:birds.border = ["#8f8475", 102]
let s:birds.window = ["#6a5d53", 59] " statusline
let s:birds.comment = ["#6b4e32", 59] " brown

let s:birds.red =  ["#ef5d32", 203] " magenta
let s:birds.ocra =  ["#efac32", 215]
let s:birds.yellow = ["#d9d762", 185]
let s:birds.green = ["#49830c", 64]
let s:birds.blue =  ["#6c99bb", 67]
let s:birds.cyan =  ["#7daf9c", 109]
let s:birds.purple =  ["#8856d2", 98]
let s:birds.lpurple = ["#BE73FD", 135]
"   ["#86b4bb", 109] // cyan2

let s:birds.diff_green = ["#8CFF8C", 120]
let s:birds.diff_red = ["#FF7575", 210]
let s:birds.dblue = ["#204a87", 23] " dblue (info text) #2c3956

" }}}
" Highlighting Function: {{{

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

call s:HL('Folded',    'comment',  'background',     'none')

call s:HL('VertSplit',    'line',       'line',      'none')

call s:HL('Cursor',       'background', 'cursor',    'none') " vCursor, iCursor
call s:HL('Visual',       '',           'selection', 'none')

call s:HL('CursorLine',   '',           'line',      'none')
call s:HL('CursorColumn', '',           'line',      'none')
call s:HL('ColorColumn',  '',           'line',      'none')

" TabLine, TabLineFill, TabLineSel

" - Gutter
call s:HL('LineNr',       'border',     'line',      'none')
" CursorLineNr
call s:HL('SignColumn',   'border',     'line',      'none')
call s:HL('FoldColumn',   'border',     'line',      'none')

call s:HL('MatchParen',   '', '',   'inverse')

call s:HL('StatusLine',   'foreground', 'line',   'bold')
call s:HL('StatusLineNC', 'foreground', 'window', 'none')

call s:HL('Directory', 'blue', '', 'none')

call s:HL('Title', 'foreground', '', 'bold')

call s:HL('ErrorMsg', 'red', 'none', 'bold')
call s:HL('WarningMsg', 'ocra', 'none')
call s:HL('ModeMsg', 'blue', 'none')
" MoreMsg, Question

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

" -----> Syntax
" start simple
call s:HL('Special', 'foreground', '', 'none')

" next up, comments
call s:HL('Comment', 'comment', '', 'italic')
" SpecialComment
call s:HL('Todo', 'yellow', '', 'italic')
call s:HL('Error', 'red', '')

call s:HL('String', 'yellow', '', 'italic')

" --> Keywords
" generic statement
call s:HL('Statement',  'red', '', 'none')
" if, then, else, endif, swicth, etc.
call s:HL('Conditional', 'red', '', 'none')
" sizeof, "+", "*", etc.
call s:HL('Operator',    'red', '', 'none')
" case, default, etc.
call s:HL('Label',       'yellow', '', 'none')
" Repeat (for, do, while, etc.)
" hi Repeat
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


hi rubyClass ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyFunction ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE
hi rubyConstant ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=185 ctermbg=NONE cterm=NONE guifg=#d9d762 guibg=NONE gui=italic
hi rubyBlockParameter ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi rubyInclude ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi rubyRegexp ctermfg=98 ctermbg=NONE cterm=NONE guifg=#8856d2 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=98 ctermbg=NONE cterm=NONE guifg=#8856d2 guibg=NONE gui=NONE
call s:HL('rubyRegexpSpecial', 'lpurple', '', 'none')
hi rubyEscape ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE
hi rubyControl ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi rubyOperator ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyException ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE

hi rubyRailsUserClass ctermfg=188 ctermbg=NONE cterm=NONE guifg=#e6e1c4 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE

hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=59 ctermbg=NONE cterm=NONE guifg=#6b4e32 guibg=NONE gui=italic
hi erubyRailsMethod ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE

hi htmlTag ctermfg=109 ctermbg=NONE cterm=NONE guifg=#86b4bb guibg=NONE gui=NONE
hi htmlEndTag ctermfg=109 ctermbg=NONE cterm=NONE guifg=#86b4bb guibg=NONE gui=NONE
hi htmlTagName ctermfg=109 ctermbg=NONE cterm=NONE guifg=#86b4bb guibg=NONE gui=NONE
hi htmlArg ctermfg=109 ctermbg=NONE cterm=NONE guifg=#86b4bb guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE

hi javaScriptFunction ctermfg=203 ctermbg=NONE cterm=NONE guifg=#ef5d32 guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

hi yamlKey ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi yamlAlias ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=185 ctermbg=NONE cterm=NONE guifg=#d9d762 guibg=NONE gui=italic

hi cssURL ctermfg=109 ctermbg=NONE cterm=NONE guifg=#7daf9c guibg=NONE gui=NONE
hi cssFunctionName ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi cssColor ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi cssClassName ctermfg=215 ctermbg=NONE cterm=NONE guifg=#efac32 guibg=NONE gui=NONE
hi cssValueLength ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=67 ctermbg=NONE cterm=NONE guifg=#6c99bb guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
