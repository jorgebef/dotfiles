local opts = {
	log_level = "info",
	auto_session_enable_last_session = false,
	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
	-- auto_session_root_dir = '~/.config/nvim/sessions/',
	auto_session_enabled = true,
	auto_save_enabled = true,
	auto_restore_enabled = false,
	auto_session_suppress_dirs = nil,
	auto_session_use_git_branch = nil,
	-- the configs below are lua only
	bypass_session_save_file_types = nil,
}

require("auto-session").setup(opts)

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
remap("n", "<leader>ss", ":SaveSession<cr>", nsn_opts)
remap("n", "<leader>sl", ":RestoreSession<cr><cr>", nsn_opts)
