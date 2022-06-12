-- vim.g.dashboard_default_executive = "telescope"

-- vim.api.nvim_exec(
-- 	[[
--   " Default value is clap
-- let g:dashboard_default_executive ='telescope'
--
-- let g:dashboard_custom_header = [
-- \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
-- \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
-- \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
-- \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
-- \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
-- \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
-- \]
--
-- ]],
-- 	false
-- )

local home = os.getenv("HOME")
local db = require("dashboard")
-- db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
-- db.preview_file_height = 12
-- db.preview_file_width = 80
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently laset session                  ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "DashboardFindHistory",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "File Browser                            ",
		action = "Telescope file_browser",
		shortcut = "SPC f b",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		aciton = "DashboardFindWord",
		shortcut = "SPC f w",
	},
	{
		icon = "  ",
		desc = "Open Personal dotfiles                  ",
		action = "Telescope dotfiles path=" .. home .. "/.dotfiles",
		shortcut = "SPC f d",
	},
}

-- local remap = vim.api.nvim_set_keymap
-- local n_opts = { noremap = true }

-- remap("n", "<leader>ss", ":SessionSave<CR>", n_opts)
-- remap("n", "<leader>sl", ":SessionLoad<CR>", n_opts)
