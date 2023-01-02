local M = { "christoomey/vim-tmux-navigator" }

function M.config()
	vim.cmd([[let g:tmux_navigator_no_wrap = 1]])
end

return M
