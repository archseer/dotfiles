" Vim color file
" Author: Blaž Hrastnik
"
" Note:

" Bootstrap: 

hi clear
if exists("syntax_on") | syntax reset | endif
set background=dark
let g:colors_name = "moon"

" Moon Colorscheme for GUI

let s:moon = {}

let s:moon.foreground      = ["#FFFFFF", 1]
let s:moon.foreground_dark = ["#7A7A7A", 1]
let s:moon.background       = ["#2B2B2B", 1]
let s:moon.background_light  = ["#3C3C3C", 1]

let s:moon.builtin  = ["#F69385", 1]
let s:moon.string   = ["#F1BF8E", 1]
let s:moon.proper   = ["#99CBCA", 1]
let s:moon.bool     = ["#B3EFE5", 1]
let s:moon.func     = ["#B0D89C", 1]
let s:moon.punct    = ["#F277A1", 1]
let s:moon.keyword  = ["#BB84B4", 1]
let s:moon.comment  = ["#929292", 1]
let s:moon.number   = ["#9D8FF2", 1]

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
      let color = get(s:moon, a:fg)
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
      let color = get(s:moon, a:1)
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

call s:HL('VertSplit', 'background_light', 'background_light', "")

call s:HL("CursorLine", "", 'background_light', "none")
call s:HL("CursorColumn", "", 'background_light', "none")
call s:HL("ColorColumn", "", 'background_light', "none")

call s:HL("Normal", 'foreground', 'background', "none")

call s:HL("Identifier", 'builtin', "", "")
call s:HL("Function", 'func', "", "")

call s:HL("Keyword", 'keyword', "", "")
call s:HL("Conditional", 'keyword', "", "")
call s:HL("Repeat", 'keyword', "", "")
call s:HL("Statement", 'keyword', "", "")

call s:HL("Comment", 'comment', "", "")
call s:HL("Todo", 'comment', "", "")

call s:HL("Operator", 'punct', "", "")
call s:HL("PreProc", 'punct', "", "")
call s:HL("Define", 'keyword', "", "")

call s:HL("Boolean", 'bool', "", "")

call s:HL("Type", 'proper', "", "")
call s:HL("Structure", 'proper', "", "")
call s:HL("Constant", 'proper', "", "")

call s:HL("String", 'string', "", "")
call s:HL("Number", 'number', "", "")
call s:HL("Float", 'number', "", "")

call s:HL("LineNr", 'background_light', "", "")
call s:HL("StatusLine", 'background_light', 'foreground', "")
call s:HL("StatusLineNC", 'background_light', 'foreground_dark', "")

call s:HL("Title", 'foreground', "", "bold")

" TODO:
" call s:HL("Error", "", "", "")
" call s:HL("SpecialChar", "", "", "")
"

" Ruby
call s:HL("rubySymbol", 'punct', "", "")
call s:HL("rubyConstant", 'proper', "", "") " same as constant
call s:HL("rubyStringDelimiter", 'string', "", "")
call s:HL("rubyIdentifier", 'proper', "", "")

call s:HL("rubyRailsMethod", 'proper', "", "")

" HTML
call s:HL("htmlTag",     'keyword', "", "")
call s:HL("htmlEndTag",  'keyword', "", "")
call s:HL("htmlTagName", 'keyword', "", "")
call s:HL("htmlArg",     'func', "", "")

" YAJS
call s:HL("javascriptImport", 'keyword', "", "")
call s:HL("javascriptExport", 'keyword', "", "")
call s:HL("javascriptIdentifier", 'proper', "", "")
call s:HL("javascriptIdentifierName", 'proper', "", "")
call s:HL("javascriptObjectLabel", 'punct', "", "")
" javascriptBraces
" typescriptBraces

" YAML

" CSS
