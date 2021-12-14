

function! MyHighlights() abort

" let l:pal = sonokai#get_palette('belf')
" calling the funcs
" call sonokai#highlight('Pmenu', l:pal.fg, l:pal.bg1)
" call sonokai#highlight('NormalFloat', l:pal.fg, l:pal.bg1)
" call sonokai#highlight('FloatBorder', l:pal.grey, l:pal.bg1)
" call sonokai#highlight('IndentBlanklineContextChar', l:pal.fg, l:pal.none)
" call sonokai#highlight('IndentBlanklineChar', l:pal.bg4, l:pal.none)
" call sonokai#highlight('DiagnosticSignError', l:pal.red, l:pal.none)
" call sonokai#highlight('DiagnosticSignWarning', l:pal.orange, l:pal.none)
" call sonokai#highlight('DiagnosticSignInformation', l:pal.yellow, l:pal.none)
" call sonokai#highlight('DiagnosticSignHint', l:pal.blue, l:pal.none)
" --------- linking

  let palette = {
        \ 'flamingo':'#ECBFBD',
        \ 'magenta':'#C6AAE8',
        \ 'pink':'#F0AFE1',
        \ 'red':'#E28C8C',
        \ 'peach':'#F7C196',
        \ 'yellow':'#EADDA0',
        \ 'green':'#B3E1A3',
        \ 'blue':'#A4B9EF',
        \ 'black1':'#15121C',
        \ 'black2':'#1B1923',
        \ 'black3':'#1E1E28',
        \ 'black4':'#2D293B',
        \ 'black5':'#3e4058',
        \ 'gray':'#6E6C7C',
        \ 'lightgray':'#9E9EA9',
        \ 'white':'#D7DAE0',
        \ 'teal':'#9DDDCB',
        \ }

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
call Hi('Pmenu', 'NONE', palette.black4)
call Hi('PmenuSel', palette.magenta, 'NONE')
call Hi('CmpItemAbbrMatch', palette.magenta, 'NONE')
call Hi('CmpItemAbbrMatchFuzzy', palette.magenta, 'NONE')
call Hi('CmpItemAbbr', palette.lightgray, 'NONE')
call Hi('DiagnosticSignError', palette.red, 'NONE')
call Hi('FloatBorder', palette.magenta, palette.black4)
call Hi('NormalFloat', 'NONE', palette.black4)
" call Hi('CursorLineNr', palette.white, 'NONE')
call Hi('IndentBlanklineContextChar', palette.white, 'NONE')
call Hi('Search', palette.black1, palette.pink)
call Hi('IncSearch', palette.black1, palette.pink)
call Hi('Visual', 'NONE', palette.black5)
" +++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++ BETTER HIGHLIGHTS ++++++++++++++++
" +++++++++++++++++++++++++++++++++++++++++++++
" call Hi('TSTagAttribute', palette.magenta, 'NONE')
" call Hi('TSNumber', palette.yellow, 'NONE')
" call Hi('TSMethod', palette.teal, 'NONE')
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
