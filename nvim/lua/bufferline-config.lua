require('bufferline').setup {
  options = {
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics_update_in_insert = false,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    separator_style = 'thick',
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    offsets = {{filetype ='NvimTree'}},
    always_show_bufferline = true
  }
}

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local nsn_opts = { noremap = true, silent = true, nowait = true }
vim.api.nvim_set_keymap('n', '<leader>n', ':BufferLineCycleNext<CR>', nsn_opts)
vim.api.nvim_set_keymap('n', '<leader>p', ':BufferLineCyclePrev<CR>', nsn_opts)
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', nsn_opts)
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineMovePrev<CR>', nsn_opts)
