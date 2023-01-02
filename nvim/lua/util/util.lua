local M = {}

M.get_buf_option = function(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

-- get length of current word
M.get_word_length = function()
	local word = vim.fn.expand("<cword>")
	return #word
end

M.has_value = function(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- TODO not working currently
M.is_current_win = function()
	local winid = vim.g.actual_curwin
	if M.isempty(winid) then
		return false
	else
		if winid == tostring(vim.api.nvim_get_current_win()) then
			return true
		else
			return false
		end
		-- return winid == tostring(vim.api.nvim_get_current_win())
	end
end

M.isempty = function(s)
	return s == nil or s == ""
end

M.remove_augroup = function(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

M.table_merge = function(first_table, second_table)
	local result_table = {}
	for k, v in pairs(first_table) do
		result_table[k] = v
	end
	for k, v in pairs(second_table) do
		result_table[k] = v
	end
	return result_table
end

return M
