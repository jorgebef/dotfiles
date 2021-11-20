-- 'black':      ['#181819',   '237'],
--           \ 'bg0':        ['#2c2e34',   '235'],
--           \ 'bg1':        ['#33353f',   '236'],
--           \ 'bg2':        ['#363944',   '236'],
--           \ 'bg3':        ['#3b3e48',   '237'],
--           \ 'bg4':        ['#414550',   '237'],
--           \ 'bg_red':     ['#ff6077',   '203'],
--           \ 'diff_red':   ['#55393d',   '52'],
--           \ 'bg_green':   ['#a7df78',   '107'],
--           \ 'diff_green': ['#394634',   '22'],
--           \ 'bg_blue':    ['#85d3f2',   '110'],
--           \ 'diff_blue':  ['#354157',   '17'],
--           \ 'diff_yellow':['#4e432f',   '54'],
--           \ 'fg':         ['#e2e2e3',   '250'],
--           \ 'red':        ['#fc5d7c',   '203'],
--           \ 'orange':     ['#f39660',   '215'],
--          \ 'yellow':     ['#e7c664',   '179'],
--           \ 'green':      ['#9ed072',   '107'],
--           \ 'blue':       ['#76cce0',   '110'],
--           \ 'purple':     ['#b39df3',   '176'],
--           \ 'grey':       ['#7f8490',   '246'],
--           \ 'grey_dim':   ['#595f6f',   '240'],
--           \ 'none':       ['NONE',      'NONE'] 
local colors = {
  black        = '#2c2e34',
  white        = '#e2e2e3',
  red          = '#fc5d7c',
  green        = '#9ed072',
  blue         = '#76cce0',
  yellow       = '#e7c664',
  gray         = '#7f8490',
  darkgray     = '#414550',
  lightgray    = '#595f6f',
  inactivegray = '#363944',
}
return {
  normal = {
    a = {bg = colors.black, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.white},
    c = {bg = colors.darkgray, fg = colors.gray}
  },
  insert = {
    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.white},
    c = {bg = colors.lightgray, fg = colors.white}
  },
  visual = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.white},
    c = {bg = colors.inactivegray, fg = colors.black}
  },
  replace = {
    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.white},
    c = {bg = colors.black, fg = colors.white}
  },
  command = {
    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
    b = {bg = colors.lightgray, fg = colors.white},
    c = {bg = colors.inactivegray, fg = colors.black}
  },
  inactive = {
    a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.gray},
    c = {bg = colors.darkgray, fg = colors.gray}
  },
}
-- require('lualine').setup {options = {theme = sonokai}}
