local M = { "kyazdani42/nvim-tree.lua" } -- File explorer written in lua

function M.config()
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- OR setup with some options
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 36,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          -- user mappings go here
        },
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
        icons = {
          corner = "└",
          edge = "│",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        glyphs = {
          git = {
            -- unstaged = "✗",
            unstaged = "",
            -- staged = "✓",
            staged = "",
            unmerged = "",
            renamed = "➜",
            -- untracked = "★",
            untracked = "",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = {},
      exclude = {},
    },
  })

  -- ============================== REMAPS =================================
  local nsn_opts = { noremap = true, silent = true, nowait = true }
  vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", nsn_opts)
  -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", nsn_opts)
end

return M
