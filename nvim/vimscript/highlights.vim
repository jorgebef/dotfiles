

function! MyHighlights() abort

" Colors ----------
let catppuccin0 = "#B1E3AD" " Teal
let catppuccin2 = "#F2CECF" " Flamingo
let catppuccin3 = "#C6AAE8" " Purple
let catppuccin4 = "#E5B4E2" " Pink
let catppuccin5 = "#E38C8F" " Red
let catppuccin6 = "#F9C096" " Orange
let catppuccin7 = "#BEE4ED" " Green
let catppuccin8 = "#EBDDAA" " Yellow
let catppuccin9 = "#A4B9EF"
" Dark colors ----------
let catppuccin13 = "#15121C"
let catppuccin14 = "#1B1923"
let catppuccin1 = "#1E1E28" " Black 1
let catppuccin16 = "#332E41" " Black 4
let catppuccin12 = "#575268" " Black 5
let catppuccin11 = "#6E6C7E"
let catppuccin17 = "#988BA2"
let catppuccin15 = "#C3BAC6" " Light Gray
let catppuccin10 = "#DADAE8" " White


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
call Hi('Pmenu', 'NONE', catppuccin16)
call Hi('PmenuSel', catppuccin3, 'NONE')
call Hi('FloatBorder', catppuccin3, catppuccin16)
call Hi('NormalFloat', 'NONE', catppuccin16)
call Hi('CmpItemAbbrMatch', catppuccin3, 'NONE')
call Hi('CmpItemAbbrMatchFuzzy', catppuccin3, 'NONE')
call Hi('CmpItemAbbr', catppuccin10, 'NONE')
call Hi('DiagnosticSignError', catppuccin5, 'NONE')
" call Hi('IndentBlanklineContextChar', catppuccin10, 'NONE')
" call Hi('IndentBlanklineChar', catppuccin16, 'NONE')
call Hi('Search', catppuccin1, catppuccin4)
call Hi('IncSearch', catppuccin1, catppuccin4)
" call Hi('Visual', 'NONE', catppuccin12)
" call Hi('GitSignsAdd', catppuccin0, 'NONE')
" +++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++ BETTER HIGHLIGHTS ++++++++++++++++
" +++++++++++++++++++++++++++++++++++++++++++++
" call Hi('cssTSProperty', catppuccin2, 'NONE')
" call Hi('TSTag', catppuccin6, 'NONE')
" call Hi('TSTagAttribute', catppuccin3, 'NONE')
" call Hi('TSTagDelimiter', catppuccin5, 'NONE')
" call Hi('TSFloat', catppuccin6, 'NONE')
" call Hi('TSNumber', color_palette.yellow, 'NONE')
" call Hi('TSVariable', catppuccin2, 'NONE')
" call Hi('TSKeyword', catppuccin4, 'NONE')
" call Hi('TSKeywordFunction', catppuccin4, 'NONE')
" call Hi('TSConditional', catppuccin4, 'NONE')
" call Hi('TSRepeat', catppuccin4, 'NONE')
" call Hi('TSType', catppuccin2, 'NONE')
" call Hi('TSMethod', color_palette.teal, 'NONE')
" +++++++++++++++++++++++++++++++++++++++++++++
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
