local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- { "nvim-telescope/telescope-frecency.nvim" },
    -- { "nvim-telescope/telescope-file-browser.nvim" },
    -- { "natecraddock/telescope-zf-native.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },

    { "scottmckendry/telescope-resession.nvim" },

    -- FILE PREVIEWER
    -- { "nvim-telescope/telescope-media-files.nvim" },
    -- { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local ui = require("config.ui")
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  ---@type Util
  local util = require("util.util")

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
          -- "--no-ignore-vcs",
        },
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
      -- prompt_prefix = ui.common.Telescope .. " " .. ui.misc.Carat,
      prompt_prefix = ui.common.Telescope .. " ",
      -- selection_caret = ui.common.Arrow,
      selection_caret = "▌ ",
      -- border = false,
      -- borderchars = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
      -- results_title = false,
      -- prompt_title = false,

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
      resession = {
        prompt_title = "Find Sessions", -- telescope prompt title
        dir = "session", -- directory where resession stores sessions
      },
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

  -- ==================Custom function for git files=======================
  local function project_files()
    local ok = pcall(builtin.git_files, { show_untracked = true })
    if not ok then
      require("telescope.builtin").find_files()
    end
  end

  -- ======================== REMAPS ============================
  local nsn_opts = { noremap = true, silent = true, nowait = true }

  -- vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope frecency<CR>", nsn_opts)

  vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep()
  end, util.table_merge(nsn_opts, { desc = "Telescope live grep" }))

  vim.keymap.set("n", "<leader>fj", function()
    builtin.jumplist()
  end, nsn_opts)

  vim.keymap.set("n", "<leader>ff", function()
    -- project_files()
    builtin.find_files()
  end, nsn_opts)

  vim.keymap.set("n", "<leader>fF", builtin.find_files, nsn_opts)

  vim.keymap.set("n", "<leader>fb", function()
    vim.cmd.Telescope("file_browser")
  end, nsn_opts)

  vim.keymap.set("n", "<leader>fG", function()
    builtin.git_files()
  end, nsn_opts)

  vim.keymap.set("n", "<leader>fS", function()
    builtin.lsp_document_symbols()
  end, nsn_opts)

  vim.keymap.set("n", "<leader>fs", function()
    telescope.extensions.resession.resession()
  end, nsn_opts)

  -- vim.keymap.set("n", "<leader>fS", function()
  --   builtin.lsp_dynamic_workspace_symbols()
  -- end, nsn_opts)

  vim.keymap.set("n", "<leader>fn", function()
    telescope.extensions.notify.notify()
  end, nsn_opts)

  vim.keymap.set("n", "<leader>fr", function()
    builtin.resume()
  end, nsn_opts)
end

return M
