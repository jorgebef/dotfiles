return {
  "ibhagwan/fzf-lua",
  enabled = false,
  -- optional for icon support
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },
  },

  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local ui = require("config.ui")
    -- calling `setup` is optional for customization
    fzf.setup({
      { "telescope", "hide" },
      winopts = {
        preview = {
          default = "builtin",
          scrollbar = false,
          -- border = ui.border.BlockThick,
          border = ui.border.BlockThickRight,
        },
        border = ui.border.BlockThick,
        backdrop = 65,
      },
      files = {
        previewer = "builtin", -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt = "Files❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = false, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- path_shorten   = 1,              -- 'true' or number, shorten path?
        -- Uncomment for custom vscode-like formatter where the filename is first:
        -- e.g. "fzf-lua/previewer/fzf.lua" => "fzf.lua previewer/fzf-lua"
        -- formatter      = "path.filename_first",
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
        -- by default, cwd appears in the header only if {opts} contain a cwd
        -- parameter to a different folder than the current working directory
        -- uncomment if you wish to force display of the cwd as part of the
        -- query prompt string (fzf.vim style), header line or both
        -- cwd_header = true,
        cwd_prompt = true,
        cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1, -- shortened path parts length
        toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
        toggle_hidden_flag = "--hidden", -- flag toggled in `actions.toggle_hidden`
        actions = {
          -- inherits from 'actions.files', here we can override
          -- or set bind to 'false' to disable a default action
          -- action to toggle `--no-ignore`, requires fd or rg installed
          ["ctrl-g"] = { actions.toggle_ignore },
          -- ["ctrl-h"] = false,
          -- ["ctrl-j"] = false,
          -- ["ctrl-k"] = false,
          -- ["ctrl-l"] = false,
          -- uncomment to override `actions.file_edit_or_qf`
          --   ["default"]   = actions.file_edit,
          -- custom actions are available too
          --   ["ctrl-y"]    = function(selected) print(selected[1]) end,
        },
      },
      grep = {
        -- cmd = "rg --vimgrep",
        rg_opts = "--column --hidden --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        actions = {
          ["ctrl-g"] = { actions.toggle_ignore },
        },
      },
      fzf_colors = true,
    })

    -- vim.keymap.set("n", "<leader>ff", function()
    --   fzf.files()
    -- end, { desc = "fzf-lua file picker" })
    --
    -- vim.keymap.set("n", "<leader>fg", function()
    --   fzf.live_grep()
    -- end, { desc = "fzf-lua live_grep" })
    --
    -- vim.keymap.set("n", "<leader>fr", function()
    --   fzf.resume()
    -- end, { desc = "fzf-lua reload" })
  end,

  keys = function()
    local fzf = require("fzf-lua")

    return {
      {
        "<leader>ff",
        function()
          fzf.files()
        end,
        desc = "Fzf Lua files",
      },
    }
  end,
}
