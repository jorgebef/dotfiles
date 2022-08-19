local M = {}

-- vim.cmd [[
--   function Test()
--     %SnipRun
--     call feedkeys("\<esc>`.")
--   endfunction
--
--   function TestI()
--     let b:caret = winsaveview()
--     %SnipRun
--     call winrestview(b:caret)
--   endfunction
-- ]]

-- function M.sniprun_enable()
--   vim.cmd [[
--     %SnipRun
--
--     augroup _sniprun
--      autocmd!
--      autocmd TextChanged * call Test()
--      autocmd TextChangedI * call TestI()
--     augroup end
--   ]]
--   vim.notify "Enabled SnipRun"
-- end

-- function M.disable_sniprun()
--   M.remove_augroup "_sniprun"
--   vim.cmd [[
--     SnipClose
--     SnipTerminate
--     ]]
--   vim.notify "Disabled SnipRun"
-- end

-- function M.toggle_sniprun()
--   if vim.fn.exists "#_sniprun#TextChanged" == 0 then
--     M.sniprun_enable()
--   else
--     M.disable_sniprun()
--   end
-- end

-- function M.remove_augroup(name)
--   if vim.fn.exists("#" .. name) == 1 then
--     vim.cmd("au! " .. name)
--   end
-- end

-- vim.cmd [[ command! SnipRunToggle execute 'lua require("user.functions").toggle_sniprun()' ]]

-- -- get length of current word
-- function M.get_word_length()
--   local word = vim.fn.expand "<cword>"
--   return #word
-- end

-- function M.toggle_option(option)
--   local value = not vim.api.nvim_get_option_value(option, {})
--   vim.opt[option] = value
--   vim.notify(option .. " set to " .. tostring(value))
-- end

-- function M.toggle_tabline()
--   local value = vim.api.nvim_get_option_value("showtabline", {})
--
--   if value == 2 then
--     value = 0
--   else
--     value = 2
--   end
--
--   vim.opt.showtabline = value
--
--   vim.notify("showtabline" .. " set to " .. tostring(value))
-- end

-- local diagnostics_active = true
-- function M.toggle_diagnostics()
--   diagnostics_active = not diagnostics_active
--   if diagnostics_active then
--     vim.diagnostic.show()
--   else
--     vim.diagnostic.hide()
--   end
-- end

local function td_validate(fn, ms)
	vim.validate({
		fn = { fn, "f" },
		ms = {
			ms,
			function(ms)
				return type(ms) == "number" and ms > 0
			end,
			"number > 0",
		},
	})
end

function M.debounce(fn, ms, first)
	td_validate(fn, ms)
	local timer = vim.loop.new_timer()
	local wrapped_fn

	if not first then
		function wrapped_fn(...)
			local argv = { ... }
			local argc = select("#", ...)

			timer:start(ms, 0, function()
				pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
			end)
		end
	else
		local argv, argc
		function wrapped_fn(...)
			argv = argv or { ... }
			argc = argc or select("#", ...)

			timer:start(ms, 0, function()
				pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
			end)
		end
	end
	return wrapped_fn, timer
end

-- TODO not working currently
function M.is_current()
	local winid = vim.g.actual_curwin
	if isempty(winid) then
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

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

return M
