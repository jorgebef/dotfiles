return {
  "nvim-neo-tree/neo-tree.nvim",
  -- branch = "v3.x",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },

  config = function()
    ---@type UISymbols
    local ui = require("config.ui")

    require("neo-tree").setup({
      popup_border_style = ui.border.Block,

      default_component_configs = {
        name = {
          trailing_slash = false,
          use_git_status_colors = false,
          highlight = "NeoTreeFileName",
        },
      },
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".env",
            ".env.local",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
            "node_modules",
            ".next",
            ".git",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
            -- "*node_modules*",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      window = {
        mappings = {
          ["l"] = "",
          ["<esc>"] = "",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },

      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("highlight! Cursor blend=100")
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
          end,
        },
        --   {
        --     event = "file_opened",
        --     handler = function(file_path)
        --       require("neo-tree.sources.filesystem").reset_search(state)
        --     end,
        --   },
      },
    })

    -- ============================== REMAPS =================================
    local nsn_opts = { noremap = true, silent = true, nowait = true }
    vim.keymap.set("n", "<leader>e", ":Neotree float toggle reveal<CR>", nsn_opts)
    -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", nsn_opts)
  end,
}
