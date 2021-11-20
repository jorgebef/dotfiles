-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local map = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', nsn_opts)
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', nsn_opts)
map('n', '<leader>fG', '<cmd>lua require("telescope.builtin").git_files()<cr>', nsn_opts)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', nsn_opts)
map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', nsn_opts)
-- map('n', '<leader>fg', ':Telescope live_grep<cr>', nsn_opts)
