local wezterm = require("wezterm")

local function keybind(mods, key, action)
  return { mods = mods, key = key, action = action }
end

local modifiers = "CTRL|ALT"

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
  -- font = wezterm.font("JetBrainsMono Nerd Font"),
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 15.0,

  -- Cursor style
  cursor_blink_rate = 0,

  -- https://wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=modifiers#keyboard-concepts:~:text=macOS%20Left%20and%20Right%20Option%20Key
  send_composed_key_when_right_alt_is_pressed = true,

  -- max_fps = 240,
  max_fps = 180,
  -- max_fps = 120,
  -- max_fps = 100,
  -- max_fps = 60,
  -- max_fps = 30,

  automatically_reload_config = true,
  -- automatically_reload_config = false,
  check_for_updates = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,

  -- window_close_confirmation = "NeverPrompt",

  window_decorations = "RESIZE",
  initial_cols = 300,
  initial_rows = 80,

  -- unzoom_on_switch_pane = true,

  -- Enable CSI u mode
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
  -- This enables using C-. and C-, as keybindings in TMUX for example
  enable_csi_u_key_encoding = true,

  disable_default_key_bindings = true,

  keys = {
    -- { key = "n", mods = "CMD", action = "SpawnWindow" },
    {
      key = "q",
      mods = "CMD",
      action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
    { key = "v", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
    -- { key = "p", mods = modifiers, action = wezterm.action({ ActivateTabRelative = -1 }) },
    -- {
    -- 	key = "Space",
    -- 	mods = modifiers,
    -- 	action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    -- },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A

    -- { key = "h", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    -- { key = "l", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    -- { key = "k", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    -- { key = "j", mods = modifiers, action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    -- =================================================================

    -- {
    --   key = "Space",
    --   mods = modifiers,
    --   action = wezterm.action("TogglePaneZoomState"),
    -- },

    -- {
    --   key = "Enter",
    --   mods = modifiers,
    --   action = wezterm.action({
    --     SplitVertical = {
    --       domain = "CurrentPaneDomain",
    --     },
    --   }),
    -- },
    -- {
    --   key = "ñ",
    --   mods = modifiers,
    --   action = wezterm.action({
    --     SplitHorizontal = {
    --       domain = "CurrentPaneDomain",
    --     },
    --   }),
    -- },

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
  term = "wezterm",
}
