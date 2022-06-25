local wezterm = require("wezterm")
local catppuccin = require("colors/catppuccin").setup({
	sync = false,
	flavour = "macchiato",
})

local modifiers = "CTRL|ALT"

local function keybind(mods, key, action)
	return { mods = mods, key = key, action = action }
end

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

return {
	hide_tab_bar_if_only_one_tab = false,
	colors = catppuccin,
	window_background_opacity = 1.0,
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 13.0,

	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	harfbuzz_features = { "zero", "kern", "liga", "clig" },

	-- Cursor style
	automatically_reload_config = false,
	check_for_updates = false,
	tab_bar_at_bottom = true,

	window_decorations = "RESIZE",
	initial_cols = 999,
	initial_rows = 999,

	unzoom_on_switch_pane = true,

	-- Enable CSI u mode
	-- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
	enable_csi_u_key_encoding = true,

	-- disable_default_key_bindings = true,

	keys = {
		{ key = "n", mods = modifiers, action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "p", mods = modifiers, action = wezterm.action({ ActivateTabRelative = -1 }) },
		-- {
		-- 	key = "Space",
		-- 	mods = modifiers,
		-- 	action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		-- },
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A

		{ key = "h", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "k", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "j", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		-- =================================================================

		{
			key = "z",
			mods = modifiers,
			action = wezterm.action("TogglePaneZoomState"),
		},

		{
			key = "Enter",
			mods = modifiers,
			action = wezterm.action({
				SplitHorizontal = {
					domain = "CurrentPaneDomain",
				},
			}),
		},

		keybind(
			modifiers,
			"Enter",
			wezterm.action_callback(function(win, pane)
				local exe = basename(pane:get_foreground_process_name())
				if exe == "nvim" then
					-- win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
					win:perform_action(
						wezterm.action({
							SplitVertical = {
								domain = "CurrentPaneDomain",
							},
						}),
						pane
					)
					win:perform_action(
						wezterm.action({
							ActivatePaneDirection = "Down",
						}),
						pane
					)
				else
					win:perform_action(
						wezterm.action({
							SplitHorizontal = {
								domain = "CurrentPaneDomain",
							},
						}),
						pane
					)
					win:perform_action(
						wezterm.action({
							ActivatePaneDirection = "Right",
						}),
						pane
					)
				end
			end)
		),

		keybind(
			modifiers,
			"Space",
			wezterm.action_callback(function(win, pane)
				local exe = basename(pane:get_foreground_process_name())
				if exe == "nvim" then
					-- win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
					win:perform_action(
						wezterm.action({
							ActivatePaneDirection = "Down",
						}),
						pane
					)
				else
					win:perform_action(
						wezterm.action({
							ActivatePaneDirection = "Up",
						}),
						pane
					)
					win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
				end
			end)
		),
		-- =================================================================
	},
}
