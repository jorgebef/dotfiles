

function! MyHighlights() abort

" Colors --------------------------
let	pink = "#F5BFE7"
let	flamingo = "#F2CBCB"
let	cotton = "#F3DCAC"
let	yellow = "#F1D0D8"
let	rosewater = "#F5DFDA"
let	mauve = "#C59FF6"
let	red = "#F67E98"
let	maroon = "#F1949B"
let	peach = "#FEA571"
let	green = "#9CDA83"
let	sapphire = "#34C3DC"
let	blue = "#83ABF9"
let	teal = "#78DCCC"
let	sky = "#89DCFD"
let	lavender = "#C1CAFE"
let	white = "#C5CFF5"
let	gray2 = "#B9C0DB"
let	gray1 = "#6F7599"
let	gray0 = "#5E6487"
let	black4 = "#3E435E"
let	black3 = "#2B3045"
let	black2 = "#24273A"
let	black1 = "#1F2233"
let	black0 = "#1A1B26"

function! Hi(group, fg, bg, ...) "{{{
  execute 'highlight! ' a:group
        \ a:fg == 'NONE' ?
        \ '' :
        \ 'guifg=' . a:fg
        \ a:bg == 'NONE' ?
        \ '' :
        \ 'guibg=' . a:bg
endfunction "}}}

" hi! Pmenu guibg=#2D293B
call Hi('Pmenu', 'NONE', black3)
call Hi('PmenuSel', mauve, 'NONE')
call Hi('FloatBorder', mauve, black3)
call Hi('NormalFloat', 'NONE', black3)
call Hi('CmpItemAbbrMatch', mauve, 'NONE')
call Hi('CmpItemAbbrMatchFuzzy', mauve, 'NONE')
call Hi('CmpItemAbbr', white, 'NONE')
call Hi('DiagnosticSignError', red, 'NONE')
" call Hi('IndentBlanklineContextChar', white, 'NONE')
" call Hi('IndentBlanklineChar', black3, 'NONE')
call Hi('Search', black2, pink)
call Hi('IncSearch', black2, pink)

call Hi('javascriptTSConstructor',lavender,'NONE')
call Hi('javascriptTSTagDelimiter',maroon,'NONE')
call Hi('javascriptTSTagAttribute',mauve,'NONE')
call Hi('cssTSProperty',cotton,'NONE')
call Hi('javascriptTSProperty',cotton,'NONE')
" +++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++ BETTER HIGHLIGHTS ++++++++++++++++
" +++++++++++++++++++++++++++++++++++++++++++++
hi! link DiagnosticVirtualTextError DiagnosticSignError
hi! link DiagnosticFloatingError DiagnosticSignError
hi! link DiagnosticVirtualTextWarning DiagnosticSignWarning
hi! link DiagnosticFloatingWarning DiagnosticSignWarning
hi! link DiagnosticVirtualTextInformation DiagnosticSignInformation
hi! link DiagnosticFloatingInformation DiagnosticSignInformation
hi! link DiagnosticVirtualTextHint DiagnosticSignHint
hi! link DiagnosticFloatingHint DiagnosticSignHint
endfunction
" Allowing JSON comments
augroup JSON_allow_comments
  autocmd!
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  autocmd BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
augroup END
" running the function at the end
augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
