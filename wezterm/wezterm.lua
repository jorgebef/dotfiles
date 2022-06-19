local wezterm = require("wezterm")
local catppuccin = require("colors/catppuccin").setup({
	-- whether or not to sync with the system's theme
	sync = false,
	-- the flavours to switch between when syncing
	-- sync_flavours = {
	-- 	light = "latte",
	-- 	dark = "mocha",
	-- },
	flavour = "macchiato",
})

local modifiers = "CTRL|ALT"

return {
	-- Smart tab bar [distraction-free mode]
	hide_tab_bar_if_only_one_tab = false,

	colors = catppuccin,

	window_background_opacity = 0.99,

	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 13.0,

	-- Disable ligatures
	-- https://wezfurlong.org/wezterm/config/font-shaping.html
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	-- harfbuzz_features = { "zero", "kern", "liga", "clig" },
	harfbuzz_features = {  "liga=0", "clig=0" },

	-- Cursor style
	-- default_cursor_style = "BlinkingBar",

	window_decorations = "RESIZE",

	-- Enable CSI u mode
	-- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
	-- enable_csi_u_key_encoding = true,

	-- timeout_milliseconds defaults to 1000 and can be omitted
	-- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "n",
			mods = modifiers,
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{ key = "p", mods = modifiers, action = wezterm.action({ ActivateTabRelative = -1 }) },
	},
}
