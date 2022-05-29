

function! MyHighlights() abort

" Colors --------------------------

let rosewater = "#F4DBD6"
let flamingo = "#F0C6C6"
let pink = "#F5BDE6"
let mauve = "#C6A0F6"
let red = "#ED8796"
let maroon = "#EE99A0"
let peach = "#F5A97F"
let yellow = "#EED49F"
let green = "#A6DA95"
let teal = "#8BD5CA"
let sky = "#91D7E3"
let sapphire = "#7DC4E4"
let blue = "#8AADF4"
let lavender = "#B7BDF8"
let text = "#CAD3F5"
let subtext1 = "#B8C0E0"
let subtext0 = "#A5ADCB"
let overlay2 = "#939AB7"
let overlay1 = "#8087A2"
let overlay0 = "#6E738D"
let surface2 = "#5B6078"
let surface1 = "#494D64"
let surface0 = "#363A4F"
let base = "#24273A"
let mantle = "#1E2030"
let crust = "#181926"

function! Hi(group, fg, bg,  ...) "{{{
  execute 'highlight! ' a:group
        \ a:fg == 'NONE' ?
        \ '' :
        \ 'guifg=' . a:fg
        \ a:bg == 'NONE' ?
        \ '' :
        \ 'guibg=' . a:bg
endfunction "}}}

call Hi('Pmenu', 'NONE', surface0)
call Hi('PmenuSel', mauve, surface1)
call Hi('FloatBorder', mauve, surface0)
call Hi('CmpItemAbbrMatch', mauve, 'NONE')
call Hi('CmpItemAbbrMatchFuzzy', mauve, 'NONE')

" call Hi('Normal',text, surface0)
" call Hi('NormalNC',text, surface0)
" call Hi('NormalSB',text, surface0)
call Hi('NormalFloat', 'NONE', surface0)

call Hi('javascriptTSConstructor',lavender,'NONE')
call Hi('javascriptTSTagDelimiter',maroon,'NONE')
call Hi('javascriptTSTagAttribute',mauve,'NONE')
call Hi('cssTSProperty',yellow,'NONE')
call Hi('javascriptTSProperty',yellow,'NONE')

call Hi('typescriptTSProperty',yellow,'NONE')
call Hi('tsxTSTagDelimiter',maroon,'NONE')
" call Hi('tsxTSProperty',yellow,'NONE')

" call Hi('jsoncComment',surface1,'NONE')
" call Hi('jsoncLineComment',surface1,'NONE')

" call Hi('IndentBlanklineChar',surface1,'NONE')

" +++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++ BETTER HIGHLIGHTS ++++++++++++++++
" +++++++++++++++++++++++++++++++++++++++++++++

call Hi('BufferLineIndicatorSelected',mauve,'NONE')
call Hi('BufferLineModified',red,'NONE')
call Hi('BufferLineModifiedVisible',red,'NONE')
call Hi('BufferLineModifiedSelected',red,'NONE')
call Hi('BufferLineBufferVisible',text,'inactive_bg')
call Hi('BufferLineBackground',overlay1,'inactive_bg')

call Hi('TelescopePreviewTitle',mauve,'NONE')
call Hi('TelescopeResultsTitle',mauve,'NONE')
call Hi('TelescopePromptTitle',mauve,'NONE')
call Hi('TelescopePromptPrefix',sapphire,'NONE')
call Hi('TelescopeMatching',mauve,'NONE')
call Hi('TelescopeSelectionCaret',red,surface0)
call Hi('TelescopeBorder',overlay0,'NONE')

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
