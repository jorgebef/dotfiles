

function! MyHighlights() abort

" Colors --------------------------

let	rosewater = "#F5DFDA"
let	flamingo = "#F2CBCB"
let	pink = "#F5BFE7"
let	mauve = "#C59FF6"
let	red = "#F67E98"
let	maroon = "#F1949B"
let	peach = "#FEA571"
let	yellow = "#F1D8A4"
let	green = "#A1DF8E"
let	teal = "#85E0D1"
let	sky = "#89DCFD"
let	blue = "#83ABF9"
let	sapphire = "#34C3DC"
let	lavender = "#B8C1FE"
let	white = "#C5CFF5"
let	gray2 = "#AEB7DA"
let	gray1 = "#979FC0"
let	gray0 = "#8087A5"
let	black5 = "#696F8A"
let	black4 = "#52576F"
let	black3 = "#3B3F55"
let	black2 = "#24273A"
let	black1 = "#1F2232"
let	black0 = "#181926"



function! Hi(group, fg, bg,  ...) "{{{
  execute 'highlight! ' a:group
        \ a:fg == 'NONE' ?
        \ '' :
        \ 'guifg=' . a:fg
        \ a:bg == 'NONE' ?
        \ '' :
        \ 'guibg=' . a:bg
endfunction "}}}

call Hi('Pmenu', 'NONE', black2)
call Hi('PmenuSel', mauve, black3)
call Hi('FloatBorder', mauve, black2)
call Hi('CmpItemAbbrMatch', mauve, 'NONE')
call Hi('CmpItemAbbrMatchFuzzy', mauve, 'NONE')

" call Hi('Normal',white, black2)
" call Hi('NormalNC',white, black2)
" call Hi('NormalSB',white, black2)
call Hi('NormalFloat', 'NONE', black2)

call Hi('javascriptTSConstructor',lavender,'NONE')
call Hi('javascriptTSTagDelimiter',maroon,'NONE')
call Hi('javascriptTSTagAttribute',mauve,'NONE')
call Hi('cssTSProperty',yellow,'NONE')
call Hi('javascriptTSProperty',yellow,'NONE')

call Hi('typescriptTSProperty',yellow,'NONE')
call Hi('tsxTSTagDelimiter',maroon,'NONE')
" call Hi('tsxTSProperty',yellow,'NONE')

" call Hi('jsoncComment',black3,'NONE')
" call Hi('jsoncLineComment',black3,'NONE')

" call Hi('IndentBlanklineChar',black3,'NONE')

" +++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++ BETTER HIGHLIGHTS ++++++++++++++++
" +++++++++++++++++++++++++++++++++++++++++++++

call Hi('BufferLineIndicatorSelected',pink,'NONE')
call Hi('BufferLineBufferVisible',white,'inactive_bg')
call Hi('BufferLineBackground',gray0,'inactive_bg')

endfunction

" " Allowing JSON comments
" augroup JSON_allow_comments
"   autocmd!
"   autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
"   autocmd BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
" augroup END

" running the function at the end
augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
