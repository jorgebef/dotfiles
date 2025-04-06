return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },

  config = function()
    require("gitsigns").setup({
      signs = {
        add = {
          -- hl = "GitSignsAdd",
          text = "│",
          -- numhl = "GitSignsAddNr",
          -- linehl = "GitSignsAddLn",
        },
        change = {
          -- hl = "GitSignsChange",
          text = "│",
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
        delete = {
          -- hl = "GitSignsDelete",
          -- text = "_",
          text = "│",
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          -- hl = "GitSignsDelete",
          -- text = "‾",
          text = "│",
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          -- hl = "GitSignsChange",
          -- text = "~",
          text = "│",
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
      },

      on_attach = function(buffer)
        -- easly close diffview with q
        vim.keymap.set("n", "q", function()
          local has_diff = vim.wo.diff
          local target_win

          if not has_diff then
            return "q"
          end

          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            local bufname = vim.api.nvim_buf_get_name(buf)
            if bufname:find("^gitsigns://") then
              target_win = win
              break
            end
          end
          if target_win then
            vim.schedule(function()
              vim.api.nvim_win_close(target_win, true)
            end)
            return ""
          end

          return "q"
        end, { expr = true, silent = true })
      end,

      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
  end,

  keys = function()
    local gs = require("gitsigns")

    return {
      {
        "]c",
        function()
          gs.nav_hunk("next")
        end,
        desc = "Goto next hunk",
      },
      {
        "[c",
        function()
          gs.nav_hunk("prev")
        end,
        desc = "Goto prev hunk",
      },
      {
        "<leader>hs",
        function()
          gs.stage_hunk()
        end,
        desc = "Stage hunk",
      },
      {
        -- "v",
        "<leader>hs",
        function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Stage hunk visual",
      },
      {
        "<leader>hr",
        function()
          gs.reset_hunk()
        end,
        desc = "Reset hunk",
      },
      {
        -- "v",
        "<leader>hr",
        function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Reset hunk visual",
      },
      {
        "<leader>hS",
        function()
          gs.stage_buffer()
        end,
        desc = "Stage buffer",
      },
      {
        "<leader>hR",
        function()
          gs.reset_buffer()
        end,
        desc = "Reset buffer",
      },
      {
        "<leader>hp",
        function()
          gs.preview_hunk()
        end,
        desc = "Preview hunk",
      },
      {
        "<leader>hd",
        function()
          gs.diffthis("~")
        end,
        desc = "Diff this",
      },
    }
  end,
}
