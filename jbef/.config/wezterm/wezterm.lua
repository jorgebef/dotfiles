local wezterm = require("wezterm")

return {
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 5,
		right = 5,
		top = 10,
		bottom = 10,
	},
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 1.0,
	font = wezterm.font({ family = "JetBrainsMono Nerd Font" }),
	font_size = 15.0,
	font_rules = {
		-- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html#font_rules
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold" }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "JetBrainsMono Nerd Font",
				weight = "Bold",
				italic = true,
			}),
		},
	},

	-- Disables ligatures
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	cursor_blink_rate = 0,

	-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=modifiers#keyboard-concepts:~:text=macOS%20Left%20and%20Right%20Option%20Key
	send_composed_key_when_right_alt_is_pressed = true,

	-- max_fps = 240,
	max_fps = 180,
	-- max_fps = 120,
	-- max_fps = 60,

	automatically_reload_config = true,
	check_for_updates = true,

	-- enable_tab_bar = false,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,

	-- window_close_confirmation = "NeverPrompt",

	window_decorations = "RESIZE",
	-- initial_cols = 300,
	-- initial_rows = 80,

	-- unzoom_on_switch_pane = true,

	-- Enable CSI u mode
	-- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
	-- This enables using C-. and C-, as keybindings in TMUX for example
	enable_csi_u_key_encoding = false,

	disable_default_key_bindings = false,

	keys = {
		{ key = ".", mods = "CTRL", action = wezterm.action.SendString("\x1b[46;5u") },
		{ key = ",", mods = "CTRL", action = wezterm.action.SendString("\x1b[44;5u") },
		-- This below maps CTRL+; to Alt+z, since that is a key combination that can be sent to tmux to run the popup with the session switcher
		{ key = ";", mods = "CTRL", action = wezterm.action.SendString("\x1bz") },
	},
	term = "wezterm",
}
