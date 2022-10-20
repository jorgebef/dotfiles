local wezterm = require("wezterm")
--[[ local catppuccin = require("colors/catppuccin").setup({ ]]
--[[ 	sync = false, ]]
--[[ 	flavour = "macchiato", ]]
--[[ }) ]]

local modifiers = "CTRL|ALT"

local function keybind(mods, key, action)
  return { mods = mods, key = key, action = action }
end

-- -- Equivalent to POSIX basename(3)
-- -- Given "/foo/bar" returns "bar"
-- -- Given "c:\\foo\\bar" returns "bar"
-- function basename(s)
-- 	return string.gsub(s, "(.*[/\\])(.*)", "%2")
-- end

-- -- make numbers superscript or subscript {{{
-- ---@diagnostic disable-next-line: unused-local,unused-function
-- local function style_number(number, style)
-- 	local superscript = {
-- 		"⁰",
-- 		"¹",
-- 		"²",
-- 		"³",
-- 		"⁴",
-- 		"⁵",
-- 		"⁶",
-- 		"⁷",
-- 		"⁸",
-- 		"⁹",
-- 	}
-- 	local subscript = {
-- 		"₀",
-- 		"₁",
-- 		"₂",
-- 		"₃",
-- 		"₄",
-- 		"₅",
-- 		"₆",
-- 		"₇",
-- 		"₈",
-- 		"₉",
-- 	}
--
-- 	local numbers = (style == "super") and superscript or subscript
--
-- 	local number_string = tostring(number)
-- 	local result = ""
-- 	for i = 1, #number_string do
-- 		local char = number_string:sub(i, i)
-- 		local nr = tonumber(char)
-- 		if number then
-- 			result = result .. numbers[nr + 1]
-- 		else
-- 			result = result .. char
-- 		end
-- 	end
-- 	return result
-- end
-- -- }}}
--
-- -- custom tab bar {{{
-- ---@diagnostic disable-next-line: unused-local
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local RIGHT_DIVIDER = utf8.char(0xe0bc)
--
-- 	local active_tab_index = 0
-- 	for _, t in ipairs(tabs) do
-- 		if t.is_active == true then
-- 			active_tab_index = t.tab_index
-- 		end
-- 	end
--
-- 	local active_bg = config.colors.tab_bar.active_tab.bg_color
-- 	local active_fg = config.colors.tab_bar.active_tab.fg_color
-- 	local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
-- 	local inactive_fg = config.colors.tab_bar.inactive_tab.fg_color
-- 	local new_tab_bg = config.colors.tab_bar.new_tab.bg_color
--
-- 	local s_bg, s_fg, e_bg, e_fg
--
-- 	-- the last tab
-- 	if tab.tab_index == #tabs - 1 then
-- 		if tab.is_active then
-- 			s_bg = active_bg
-- 			s_fg = active_fg
-- 			e_bg = new_tab_bg
-- 			e_fg = active_bg
-- 		else
-- 			s_bg = inactive_bg
-- 			s_fg = inactive_fg
-- 			e_bg = new_tab_bg
-- 			e_fg = inactive_bg
-- 		end
-- 	elseif tab.tab_index == active_tab_index - 1 then
-- 		s_bg = inactive_bg
-- 		s_fg = inactive_fg
-- 		e_bg = active_bg
-- 		e_fg = inactive_bg
-- 	elseif tab.is_active then
-- 		s_bg = active_bg
-- 		s_fg = active_fg
-- 		e_bg = inactive_bg
-- 		e_fg = active_bg
-- 	else
-- 		s_bg = inactive_bg
-- 		s_fg = inactive_fg
-- 		e_bg = inactive_bg
-- 		e_fg = inactive_bg
-- 	end
-- 	return {
-- 		{ Background = { Color = s_bg } },
-- 		{ Foreground = { Color = s_fg } },
-- 		{ Text = " " .. tab.tab_index + 1 .. ": " .. tab.active_pane.title .. " " },
-- 		{ Background = { Color = e_bg } },
-- 		{ Foreground = { Color = e_fg } },
-- 		{ Text = RIGHT_DIVIDER },
-- 	}
-- end)
-- -- }}}

return {
  hide_tab_bar_if_only_one_tab = false,
  -- colors = catppuccin,
  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 1.0,
  -- Constrains the rate at which output from a child command is
  -- processed and applied to the terminal model.
  -- This acts as a brake in the case of a command spewing a
  -- ton of output and allows for the UI to remain responsive
  -- so that you can hit CTRL-C to interrupt it if desired.
  -- The default value is 400,000 bytes/s.
  -- ratelimit_output_bytes_per_second = 400000,
  font = wezterm.font("JetBrainsMono Nerd Font"),
  -- font = wezterm.font("BlexMono Nerd Font"),
  -- font = wezterm.font("Hack Nerd Font"),
  -- font = wezterm.font("FiraCode Nerd Font"),
  -- font_size = 16.0,
  --[[ line_height = 0.95, ]]
  -- font_size = 13.0,
  font_size = 15.0,

  -- Cursor style
  cursor_blink_rate = 0,

  -- max_fps = 240,
  -- max_fps = 180,
  max_fps = 120,
  -- max_fps = 100,
  -- max_fps = 60,

  automatically_reload_config = true,
  check_for_updates = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,

  window_decorations = "RESIZE",
  initial_cols = 350,
  initial_rows = 80,

  -- unzoom_on_switch_pane = true,

  -- Enable CSI u mode
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
  enable_csi_u_key_encoding = false,

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
      key = "Space",
      mods = modifiers,
      action = wezterm.action("TogglePaneZoomState"),
    },

    {
      key = "Enter",
      mods = modifiers,
      action = wezterm.action({
        SplitVertical = {
          domain = "CurrentPaneDomain",
        },
      }),
    },
    {
      key = "ñ",
      mods = modifiers,
      action = wezterm.action({
        SplitHorizontal = {
          domain = "CurrentPaneDomain",
        },
      }),
    },

    -- keybind(
    -- 	modifiers,
    -- 	"Enter",
    -- 	wezterm.action_callback(function(win, pane)
    -- 		local exe = basename(pane:get_foreground_process_name())
    -- 		if exe == "nvim" then
    -- 			-- win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
    -- 			win:perform_action(
    -- 				wezterm.action({
    -- 					SplitVertical = {
    -- 						domain = "CurrentPaneDomain",
    -- 					},
    -- 				}),
    -- 				pane
    -- 			)
    -- 			win:perform_action(
    -- 				wezterm.action({
    -- 					ActivatePaneDirection = "Down",
    -- 				}),
    -- 				pane
    -- 			)
    -- 		else
    -- 			win:perform_action(
    -- 				wezterm.action({
    -- 					SplitHorizontal = {
    -- 						domain = "CurrentPaneDomain",
    -- 					},
    -- 				}),
    -- 				pane
    -- 			)
    -- 			win:perform_action(
    -- 				wezterm.action({
    -- 					ActivatePaneDirection = "Right",
    -- 				}),
    -- 				pane
    -- 			)
    -- 		end
    -- 	end)
    -- ),

    -- keybind(
    -- 	modifiers,
    -- 	"Space",
    -- 	wezterm.action_callback(function(win, pane)
    -- 		local exe = basename(pane:get_foreground_process_name())
    -- 		local tabs = win:tabs_with_info()
    -- 		for _, tab in tabs do
    -- 			if tab.is_active then
    -- 				local panes = tab:panes_with_info()
    -- 				for _, pane in panes do
    -- 					if pane.is_active then
    -- 						win:perform_action(
    -- 							wezterm.action({
    -- 								ActivatePaneDirection = "Down",
    -- 							}),
    -- 							pane
    -- 						)
    -- 					end
    -- 				end
    -- 			end
    -- 		end
    -- 		-- if exe == "nvim" then
    -- 		-- 	-- win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
    -- 		-- 	win:perform_action(
    -- 		-- 		wezterm.action({
    -- 		-- 			ActivatePaneDirection = "Down",
    -- 		-- 		}),
    -- 		-- 		pane
    -- 		-- 	)
    -- 		-- else
    -- 		-- 	win:perform_action(
    -- 		-- 		wezterm.action({
    -- 		-- 			ActivatePaneDirection = "Up",
    -- 		-- 		}),
    -- 		-- 		pane
    -- 		-- 	)
    -- 		-- 	win:perform_action(wezterm.action("TogglePaneZoomState"), pane)
    -- 		-- end
    -- 	end)
    -- ),

    -- =================================================================
  },
}
