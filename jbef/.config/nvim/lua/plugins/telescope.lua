local M = {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-frecency.nvim" },
    -- { "nvim-telescope/telescope-file-browser.nvim" },
    -- { "natecraddock/telescope-zf-native.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- FILE PREVIEWER
    -- { "nvim-telescope/telescope-media-files.nvim" },
    -- { "nvim-lua/popup.nvim" },
  },
}

function M.config()
  local ui = require("config.ui")
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  ---@type Util
  -- local util = require("util.util")

  -- You dont need to set any of these options. These are the default ones. Only
  -- the loading is important
  telescope.setup({
    pickers = {
      find_files = {
        hidden = true,
        find_command = {
          "fd",
          "--type",
          "f",
          "--color=never",
          "--follow",
          "--hidden",
          "--exclude",
          ".git",
          "--exclude",
          "node_modules",
          "--exclude",
          ".next",
        },
        results_title = false,
        prompt_title = false,
      },
      buffers = {
        -- show_all_buffers = true,
        -- sort_lastused = true,
        -- theme = "dropdown",
        -- previewer = true,
        mappings = {
          n = {
            ["<c-d>"] = "delete_buffer",
          },
        },
      },
    },
    defaults = {
      results_title = false,
      prompt_title = false,

      mappings = {
        i = {
          ["<C-S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        },
        n = {
          ["<C-S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["p"] = function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local text = vim.fn.getreg('"'):gsub("\n", "\\n") -- which register depends on clipboard option
            current_picker:set_prompt(text, false)
          end,
        },
      },

      -- prompt_prefix = ui.common.Telescope .. " " .. ui.misc.Carat,
      prompt_prefix = " " .. ui.common.Telescope .. " ",
      -- selection_caret = ui.common.Arrow,
      selection_caret = "▌ ",
      -- border = false,
      borderchars = {
        -- prompt = { " ", " ", "▄", "█", "█", " ", "▄", "█" },
        -- results = { "▀", " ", " ", "█", "█", "▀", " ", "█" },
        prompt = ui.border.Empty,
        results = ui.border.Empty,
        preview = { "▀", "█", "▄", " ", "▀", "█", "█", "▄" },
      },
      -- borderchars = { "🬂", "▐", "🬭", "▌", "🬕", "🬨", "▟", "▙" },

      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--glob",
        "!.git/",
        "--glob",
        "!package-lock.json",
        -- "--ignore-file",
        -- "!*package-lock.json",
        -- "!*package.json",
        -- '.gitignore'
      },
    },
    extensions = {
      -- notify = {},
      file_browser = {
        -- theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = false,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            ["d"] = "delete_buffer",
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
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),
      },

      project = {},
    },
  })
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  telescope.load_extension("fzf")
  -- telescope.load_extension("frecency")
  -- To get telescope-file-browser loaded and working with telescope,
  -- you need to call load_extension, somewhere after setup function:
  -- telescope.load_extension("file_browser")
  -- -- Telescope Notification history review and finder
  telescope.load_extension("notify")
  -- Telescope Media file Previewer
  -- telescope.load_extension("media_files")
  telescope.load_extension("ui-select")

  -- -- ==================Custom function for git files=======================
  -- local function project_files()
  --   local ok = pcall(builtin.git_files, { show_untracked = true })
  --   if not ok then
  --     require("telescope.builtin").find_files()
  --   end
  -- end

  -- ======================== REMAPS ============================
  -- local nsn_opts = { noremap = true, silent = true, nowait = true }

  -- vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope frecency<CR>", nsn_opts)

  vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep()
  end, { desc = "Telescope live grep" })

  vim.keymap.set("n", "<leader>fj", function()
    builtin.jumplist()
  end, { desc = "Telescope jumplist" })

  local my_find_files
  my_find_files = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.actions").close(prompt_bufnr)
        no_ignore = not no_ignore
        my_find_files({ default_text = prompt }, no_ignore)
      end)
      return true
    end

    if no_ignore then
      opts.no_ignore = true
      opts.hidden = true
      opts.prompt_title = "Find Files <ALL>"
      require("telescope.builtin").find_files(opts)
    else
      opts.prompt_title = "Find Files"
      require("telescope.builtin").find_files(opts)
    end
  end
  vim.keymap.set("n", "<leader>ff", function()
    -- project_files()
    -- builtin.find_files()
    my_find_files()
  end, { desc = "Telescope files" })

  vim.keymap.set("n", "<leader>fb", function()
    vim.cmd.Telescope("file_browser")
  end, { desc = "Telescope file browser" })

  vim.keymap.set("n", "<leader>fG", function()
    builtin.git_files()
  end, { desc = "Telescope git files" })

  vim.keymap.set("n", "<leader>fS", function()
    builtin.lsp_document_symbols()
  end, { desc = "Telescope document symbols" })

  -- vim.keymap.set("n", "<leader>fs", function()
  --   telescope.extensions.resession.resession()
  -- end, nsn_opts)

  -- vim.keymap.set("n", "<leader>fS", function()
  --   builtin.lsp_dynamic_workspace_symbols()
  -- end, nsn_opts)

  vim.keymap.set("n", "<leader>fn", function()
    telescope.extensions.notify.notify()
  end, { desc = "Telescope notify" })

  vim.keymap.set("n", "<leader>fr", function()
    builtin.resume()
  end, { desc = "Telescope resume" })

  -- CONFIG
  local blend = 60

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopePrompt",
    callback = function(ctx)
      local backdropName = "TelescopeBackdrop"
      local telescopeBufnr = ctx.buf

      -- `Telescope` does not set a zindex, so it uses the default value
      -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
      local telescopeZindex = 50

      local backdropBufnr = vim.api.nvim_create_buf(false, true)
      local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
        relative = "editor",
        row = 0,
        col = 0,
        width = vim.o.columns,
        height = vim.o.lines,
        focusable = false,
        style = "minimal",
        zindex = telescopeZindex - 1, -- ensure it's below the reference window
      })

      vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
      vim.wo[winnr].winhighlight = "Normal:" .. backdropName
      vim.wo[winnr].winblend = blend
      vim.bo[backdropBufnr].buftype = "nofile"

      -- close backdrop when the reference buffer is closed
      vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
        once = true,
        buffer = telescopeBufnr,
        callback = function()
          if vim.api.nvim_win_is_valid(winnr) then
            vim.api.nvim_win_close(winnr, true)
          end
          if vim.api.nvim_buf_is_valid(backdropBufnr) then
            vim.api.nvim_buf_delete(backdropBufnr, { force = true })
          end
        end,
      })
    end,
  })
end

return M
