-- ======================== REQUIRE EXTRA FILES ===================
require("jbef.options")
require("jbef.keymaps")
require("jbef.keymaps-leader")

-- prepare the package manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
else
	vim.opt.runtimepath:prepend(lazypath)
	require("jbef.plugins")
end

-- this uses packer package manager
-- require("jbef.packer")

require("jbef.autocommands")

vim.cmd.colorscheme("catppuccin")
