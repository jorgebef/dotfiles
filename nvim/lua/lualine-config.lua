require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- theme = 'sonokai',
    -- section_separators = { left = '█', right = '█'},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '|', right = '|'},
    -- component_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = false,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = { left = '', right = '' },
        left_padding = 1,
        right_padding = 1,
      }
    },
    lualine_b = {
      {
        'branch',
        separator = { right = '' },
        left_padding = 2,
      },
      {
      'diff',
        separator = { right = '' },
        left_padding = 1,
      },
      {'diagnostics',
        -- table of diagnostic sources, available sources:
        -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
        -- Or a function that returns a table like
        --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
        sources = {'nvim_diagnostic', 'coc'},
        -- displays diagnostics from defined severity
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        -- diagnostics_color = {
        --   error = {fg='#fc5d7c',bg=nil}, -- changes diagnostic's error color
        --   warn = {fg='#d2bb6d',bg=nil},  -- changes diagnostic's warn color
        --   info = {fg='#97d1ef',bg=nil},  -- Changes diagnostic's info color
        --   hint = {fg='#76cce0',bg=nil},  -- Changes diagnostic's hint color
        -- },
        -- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
        symbols = { error = ' ', warn = ' ', info = ' ' },
        colored = true, -- displays diagnostics status in color if set to true
        update_in_insert = false, -- Update diagnostics in insert mode
        always_visible = false, -- Show diagnostics always
        separator = { right = '' },
        left_padding = 1,
      },
    },
    lualine_c = {'filename'},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {'filetype'},
    lualine_y = {
      {
        'progress',
        separator = { left = '' },
        right_padding = 1,
      }
    },
    -- lualine_y = {'%{ObsessionStatus(" "," ")}'},
    lualine_z = {
      {
        'location',
        separator = { left = '', right = '' },
        left_padding = 1,
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    -- lualine_y = {'%{ObsessionStatus(" "," ")}'},
    lualine_z = {},
  },
  tabline = {
    -- lualine_a = {'buffers'},
    -- lualine_b = {'branch'},
    -- lualine_c = {'filename'},
    -- lualine_x = {},
    -- lualine_y = {},
    -- lualine_z = {'tabs'}
  },
  extensions = {}
}
