

function! MyHighlights() abort

" Colors ----------
let	rosewater = "#F5E0DC"
let	flamingo = "#F2CDCD"
let	mauve = "#DDB6F2"
let	pink = "#F5C2E7"
let	red = "#F28FAD"
let	maroon = "#E8A2AF"
let	peach = "#F8BD96"
let	yellow = "#FAE3B0"
let	green = "#ABE9B3"
let	blue = "#96CDFB"
let	sky = "#89DCEB"
let	teal = "#B5E8E0"
let	lavender = "#C9CBFF"
let	white = "#D9E0EE"
let	gray2 = "#C3BAC6"
let	gray1 = "#988BA2"
let	gray0 = "#6E6C7E"
let	black4 = "#575268"
let	black3 = "#302D41"
let	black2 = "#1E1D2F"
let	black1 = "#1A1823"
let	black0 = "#131020"

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
augroup END
" running the function at the end
augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
