return {
  "Shatur/neovim-session-manager",
  enabled = false,

  config = function()
    local Path = require("plenary.path")
    require("session_manager").setup({
      sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
      path_replacer = "__", -- The character to which the path separator will be replaced for session files.
      colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
      -- autoload_mode = require("session_manager.config").AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "gitcommit",
      },
      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
      max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    })

    local n_opts = { noremap = true }
    vim.keymap.set("n", "<leader>ss", ":SessionManager save_current_session<CR>", n_opts)
    vim.keymap.set("n", "<leader>sl", ":SessionManager load_current_dir_session<CR>", n_opts)
    -- vim.keymap.set("n", "þ", ":SessionManager load_session<CR>", n_opts)
  end,
} -- Session manager
