require('bufferline').setup {
  options = {
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    -- indicator_icon = '▎',
    -- indicator_icon = '█',
    -- indicator_icon = '',
    indicator_icon = '',
    modified_icon = '',
    diagnostics_update_in_insert = false,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    separator_style = 'thin',
    -- separator_style = 'slant',
    -- separator_style = { ' ', ' ' },
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    offsets = {{filetype = 'NvimTree'}},
    always_show_bufferline = true
  },
  highlights = {
    -- fill = {
    --   guibg = '#222327',
    -- },
    indicator_selected = {
      guifg = '#F28FAD',
      -- guibg = '#222327'
    },
    -- background = {
    --   guifg = '#575268',
    --   guibg = '#15121C'
    -- },
    -- separator_selected = {
    --   guifg = '#ffffff',
    --   guibg = '#000000',
    -- },
    -- separator_visible = {
    --   guifg = '#999',
    --   guibg = '#000',
    -- },
    -- separator = {
    --   guifg = '#333',
    --   guibg = '#000',
    -- },
    -- buffer_visible = {
      -- guifg = '#DFDEF1',
      -- guibg = {
      --   attribute = "bg",
      --   highlight = "Background"
      -- },
    -- },
    -- buffer_selected = {
    --   guifg = '#e2e2e3',
    --   guibg = {
    --     attribute = "bg",
    --     highlight = "Background"
    --   },
    --   gui = "bold"
    -- },
    modified = {
      guifg = '#F28FAD'
    },
    modified_visible = {
      guifg = '#F28FAD'
    },
    modified_selected = {
      guifg = '#F28FAD'
    },
  },
}

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
remap('n', '<C-n>', ':BufferLineCycleNext<CR>', nsn_opts)
remap('n', '<C-p>', ':BufferLineCyclePrev<CR>', nsn_opts)
remap('n', '<C-S-n>', ':BufferLineMoveNext<CR>', nsn_opts)
remap('n', '<C-S-p>', ':BufferLineMovePrev<CR>', nsn_opts)
