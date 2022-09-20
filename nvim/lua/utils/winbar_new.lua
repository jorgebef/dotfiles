local M = {}

-- local cp = require("catppuccin.palettes").get_palette()
local navic = require("nvim-navic")
local util = require("util")
local icons = require("icons")

M.winbar_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"alpha",
	"lir",
	"Outline",
	"spectre_panel",
	"toggleterm",
}

local excludes = function()
	if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
		vim.opt_local.winbar = nil
		return true
	end
	return false
end

local function get_modified()
	if util.get_buf_option("mod") then
		local mod = icons.ui.Circle
		local modHighlight
		if vim.g.actual_curwin == tostring(vim.api.nvim_get_current_win()) then
			modHighlight = "%#WinBarModActive#"
		else
			modHighlight = "%#WinBarModInactive#"
		end
		return modHighlight .. mod .. "%*"
	end
	return ""
end

local function get_location()
	local location = navic.get_location()
	if not util.isempty(location) then
		return location
	end
	return ""
end

local function get_filename()
	local filenameHighlight
	local separator
	if vim.g.actual_curwin == tostring(vim.api.nvim_get_current_win()) then
		filenameHighlight = "%#WinBarFilenameActive#"
		separator = " "
	else
		filenameHighlight = "%#WinBarFilenameInactive#"
		separator = ""
	end
	return filenameHighlight .. " %t" .. separator .. "%*  "
end

function M.get_winbar()
	if excludes() then
		return ""
	end
	if navic.is_available() then
		return get_filename() .. get_location() .. " " .. get_modified()
	else
		return get_filename() .. get_modified()
	end
end

return M
