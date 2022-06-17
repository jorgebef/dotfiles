local icons = require("icons")

local M = {}

local status_gps_ok, gps = pcall(require, "nvim-gps")
if not status_gps_ok then
	return
end

local get_filename = function(leaving)
	local filename = vim.fn.expand("%:t")
	local extension = ""
	local file_icon = ""
	local file_icon_color = ""
	local default_file_icon = ""
	local default_file_icon_color = ""
	local f = require("functions")

	if not f.isempty(filename) then
		extension = vim.fn.expand("%:e")

		local default = false

		if f.isempty(extension) then
			extension = ""
			default = true
		end

		file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
			filename,
			extension,
			{ default = default }
		)

		local cp = require("catppuccin.core.palettes.macchiato")
		local active_hl_group = "ActiveFileIconColor" .. extension
		local inactive_hl_group = "InactiveFileIconColor" .. extension
		vim.api.nvim_set_hl(0, active_hl_group, {
			fg = file_icon_color,
			bg = cp.surface0,
			bold = true,
		})
		vim.api.nvim_set_hl(0, inactive_hl_group, {
			fg = file_icon_color,
			bg = cp.base,
			bold = true,
		})

		if file_icon == nil then
			file_icon = default_file_icon
			file_icon_color = default_file_icon_color
		end

		local winbarIndicator = icons.misc.Ghost2

		if leaving then
			return " "
				.. "%#"
				.. inactive_hl_group
				.. "#"
				.. file_icon
				.. "%*"
				.. " "
				.. "%#WinbarInactiveFileName#"
				.. filename
				.. "%*"
		else
			return " "
				.. "%#WinBarIndicatorSelected#"
				.. winbarIndicator
				.. " "
				.. "%#"
				.. active_hl_group
				.. "#"
				.. file_icon
				.. "%*"
				.. " "
				.. "%#WinbarActiveFileName#"
				.. filename
				.. "%*"
		end
	end
end

local get_gps = function(leaving)
	local f = require("functions")
	local status_ok, gps_location = pcall(gps.get_location, {})
	if not status_ok then
		return ""
	end

	if not gps.is_available() then -- Returns boolean value indicating whether a output can be provided
		return ""
	end

	if gps_location == "error" then
		return ""
	else
		if not f.isempty(gps_location) then
			if leaving then
				return " " .. "%#WinbarInactiveGPS#" .. icons.ui.ChevronRight .. " " .. gps_location
			else
				return " " .. "%#WinbarActiveGPS#" .. icons.ui.ChevronRight .. " " .. gps_location
			end
		else
			return ""
		end
	end
end

local excludes = function()
	local winbar_filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"NvimTree_1",
		"Trouble",
		"alpha",
		"lir",
		"Outline",
		"spectre_panel",
		"toggleterm",
	}

	if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
		-- vim.opt_local.winbar = nil
		vim.opt_local.winbar = " "
		return true
	end

	return false
end

-- Pass leaving which is boolean to signal if the action is for
-- entering or leaving a buffer
M.get_winbar = function(leaving)
	if excludes() then
		return
	end
	local f = require("functions")
	local value = get_filename(leaving)

	local gps_added = false
	if not f.isempty(value) then
		local gps_value = get_gps(leaving)
		value = value .. " " .. gps_value
		if not f.isempty(gps_value) then
			gps_added = true
		end
	end

	if not f.isempty(value) and f.get_buf_option("mod") then
		local active_mod = "%#WinBarInactiveModified#" .. icons.ui.Circle .. "%*"
		local inactive_mod = "%#WinBarActiveModified#" .. icons.ui.Circle .. "%*"

		if gps_added then
			if leaving then
				value = value .. " " .. inactive_mod
			else
				value = value .. " " .. active_mod
			end
		else
			if leaving then
				value = value .. " " .. inactive_mod
			else
				value = value .. " " .. active_mod
			end
		end
	end

	local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
	if not status_ok then
		return
	end
end

return M
