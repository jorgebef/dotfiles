local icons = require("jbef.icons")
local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup({
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
      find_command = {
        "fd",
        "--color=never",
        "--type",
        "f",
        "--hidden",
        "--follow",
        "--no-ignore",
        "--exclude",
        "node_modules",
        "--exclude",
        ".git",
        "--exclude",
        "dist",
        "--exclude",
        "build",
        "--exclude",
        "out",
        "--exclude",
        ".next",
        "--exclude",
        ".vercel",
        "--exclude",
        ".netlify",
      },
    },
  },
  defaults = {
    prompt_prefix = icons.ui.Telescope .. " " .. icons.misc.Carat,
    selection_caret = icons.ui.Arrow,
    -- layout_config = {
    --   height = 0.9,
    --   preview_cutoff = 120,
    --   width = 0.8,
    --   prompt_position = "top",
    -- },
    -- sorting_strategy = "ascending",
    -- -- ====================================================
    -- -- IT IS VERY SLOW TO RELY ON FILE IGNORE PATTERNS
    -- -- ====================================================
    -- file_ignore_patterns = {
    --   "node_modules/",
    --   ".git/",
    --   ".next/",
    --   "package-lock.json",
    --   "DS_",
    -- },

    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--ignore-file",
      -- "package-lock.json",
      -- '.gitignore'
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["zf-native"] = {
      -- options for sorting file-like items
      file = {
        -- override default telescope file sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- enable zf filename match priority
        match_filename = true,
      },
      -- options for sorting all other items
      generic = {
        -- override default telescope generic item sorter
        enable = false,

        -- highlight matching text in results
        highlight_results = true,

        -- disable zf filename match priority
        match_filename = false,
      },
    },

    project = {},
  },
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")

-- Load zf extension, which favors filename over rest of the path
telescope.load_extension("zf-native")

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
telescope.load_extension("file_browser")

-- ======================================================================
-- ==================Custom function for git files=======================
-- ======================================================================
local function project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local nsn_opts = { noremap = true, silent = true, nowait = true }
-- remap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files({sort_lastused=true})<cr>', nsn_opts)
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files()
end, nsn_opts)
vim.keymap.set("n", "<leader>fj", function()
  builtin.jumplist()
end, nsn_opts)
vim.keymap.set("n", "<leader>fF", function()
  project_files()
end, nsn_opts)
vim.keymap.set("n", "<leader>fb", function()
  vim.cmd.Telescope("file_browser")
end, nsn_opts)
vim.keymap.set("n", "<leader>fG", function()
  builtin.git_files()
end, nsn_opts)
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep()
end, nsn_opts)
vim.keymap.set("n", "<leader>fs", function()
  builtin.lsp_document_symbols()
end, nsn_opts)
vim.keymap.set("n", "<leader>fS", function()
  builtin.lsp_dynamic_workspace_symbols()
end, nsn_opts)

-- =================================================================
-- SHORTCUTS FOR JUMP TO DEFINITION AND REFERENCE SET IN LSP CONFIG
-- =================================================================
-- remap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', nsn_opts)
-- remap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', nsn_opts)
-- remap("n", "<leader>fgs", '<cmd>lua require("telescope.builtin").git_status()<CR>', nsn_opts)
vim.keymap.set("n", "<leader>fr", function()
  builtin.resume()
end, nsn_opts)
-- map('n', '<leader>fg', ':Telescope live_grep<cr>', nsn_opts)