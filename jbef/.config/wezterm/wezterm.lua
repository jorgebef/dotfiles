local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local session_manager = require("user.session-manager")

local config = {
  term = "wezterm",
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = "Tokyo Night Moon",

  font = wezterm.font({
    -- family = "Fira Code",
    family = "FiraCode Nerd Font",
  }),
  font_size = 14.0,

  font_rules = {
    -- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html#font_rules
    {
      intensity = "Bold",
      italic = false,
      font = wezterm.font({
        family = "Fira Code",
        weight = "Medium",
      }),
    },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font({
        family = "Fira Code",
        weight = "Medium",
        italic = true,
      }),
    },
  },
  -- Disables ligatures
  -- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
  -- line_height = 1.05, -- specific for FiraCode font
  underline_thickness = 2, -- specific for FiraCode font
  underline_position = -5, -- specific for FiraCode font
  max_fps = 120,
  -- max_fps = 240,
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  animation_fps = 0,
  webgpu_preferred_adapter = {
    backend = "Metal",
    device = 0,
    device_type = "IntegratedGpu",
    name = "Apple M1 Pro",
    vendor = 0,
  },
  -- cursor_blink_ease_in = "Constant",
  -- cursor_blink_ease_out = "Constant",


  automatically_reload_config = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_decorations = "RESIZE",
  window_background_opacity = 0.98,
  macos_window_background_blur = 0,
  hide_tab_bar_if_only_one_tab = true, -- true if using TMUX
  tab_max_width = 999,
  window_padding = {
    left = 5,
    right = 5,
    top = 10,
    bottom = 0,
  },

  -- Enable CSI u mode
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
  -- This enables using C-. and C-, as keybindings in TMUX for example
  enable_csi_u_key_encoding = true,
  disable_default_key_bindings = false,
  hide_mouse_cursor_when_typing = true,
  cursor_blink_rate = 0,

  -- https://wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=modifiers#keyboard-concepts:~:text=macOS%20Left%20and%20Right%20Option%20Key
  send_composed_key_when_right_alt_is_pressed = true,

  mouse_bindings = {
    {
      -- Change the default click behavior so that it only selects
      -- text and doesn't open hyperlinks
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },

    -- and make CMD-Click open hyperlinks
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = act.OpenLinkAtMouseCursor,
    },
  },
}

-- Spawn a fish shell in login mode
-- config.default_prog = { "/opt/homebrew/bin/fish" }
-- config.default_prog = { "/bin/zsh" }

config.inactive_pane_hsb = {
  -- saturation = 0.7,
  saturation = 1.0,
  -- brightness = 0.9,
  brightness = 1.0,
}

config.show_new_tab_button_in_tab_bar = false
config.colors = {
  split = "#585b70",

  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = "#1E1E2E",
    -- background = "#222437",
  },
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- local title = tab.tab_title
  local left_padding = " "
  local separator = " "
  local custom_title = "------"
  local edge_background = "#1E1E2E"
  local edge_foreground = "#1E1E2E"
  -- local edge_background = "#222437"
  -- local edge_foreground = "#222437"
  local background = "#f5c2e7"
  local foreground = "#f5c2e7"

  local mux_window = mux.get_window(tab.window_id)
  local workspace = "  " .. mux:get_active_workspace()
  local mux_tab = mux_window:active_tab()
  local mux_tab_cols = mux_tab:get_size().cols

  -- local window = mux.get_window(tab.window_id)
  -- local window_dimensions = window:gui_window():get_dimensions()

  if tab.tab_index == 0 then
    left_padding = workspace
      .. string.rep(
        " ",
        math.floor(
          (mux_tab_cols - math.floor(#workspace * 2) - #tabs * math.floor(#custom_title) - (#tabs - 1) * #separator) / 2
        )
      )
  end

  if tab.is_active then
    background = "#1E1E2E"
    -- background = "#222437"
    foreground = "#f5c2e7"
    -- foreground = "#C199FF"
  else
    background = "#1E1E2E"
    -- background = "#222437"
    foreground = "#45475a"
  end

  return {
    -- { Attribute = { Intensity = "Bold" } },
    { Attribute = { Italic = true } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = "#f5c2e7" } },
    { Text = left_padding },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Italic = false } },
    { Text = custom_title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = separator },
  }
end)

-- -- ************************************************************************
-- -- If I evern want to replace tmux with wezterm native tabs and so on
-- -- ************************************************************************
-- wezterm.on("gui-startup", function(cmd)
--   local args = {}
--   if cmd then
--     args = cmd.args
--   end
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- local move_around = function(window, pane, direction_wez, direction_nvim)
--   if pane:get_title():sub(-4) == "NVIM" then
--     window:perform_action(act.SendString(direction_nvim), pane)
--   else
--     window:perform_action(act.ActivatePaneDirection(direction_wez), pane)
--   end
-- end
--
-- wezterm.on("move-left", function(window, pane)
--   move_around(window, pane, "Left", "\x08") -- for nvim, use unicode to send Ctrl+h
-- end)
--
-- wezterm.on("move-right", function(window, pane)
--   move_around(window, pane, "Right", "\x0C") -- for nvim, use unicode to send Ctrl+l
-- end)
--
-- wezterm.on("move-up", function(window, pane)
--   move_around(window, pane, "Up", "\x0B") -- for nvim, use unicode to send Ctrl+k
-- end)
--
-- wezterm.on("move-down", function(window, pane)
--   move_around(window, pane, "Down", "\x0A") -- for nvim, use unicode to send Ctrl+j
-- end)

-- wezterm.on("zellij-ctrl-j", function(window, pane)
--   local function zellij_ctrl_j()
--     if pane:get_title():sub(-4) == "NVIM" then
--       window:perform_action(act.SendString("\x0A"), pane)
--     else
--       window:perform_action(act.SendString("þ"), pane)
--     end
--   end
--   zellij_ctrl_j()
-- end)

-- -- =====================================================================
-- -- No multiplexer specific
-- config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
-- -- =====================================================================

-- =====================================================================
-- If using a multiplexer
config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
-- =====================================================================

config.keys = {
  { key = "Space", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },

  -- -- =====================================================================
  -- -- No multiplexer specific keybindings
  -- { key = ".", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(1) },
  -- { key = ",", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(-1) },
  -- { key = ".", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
  -- { key = ",", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
  -- { key = ";", mods = "CTRL", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  -- { key = "h", mods = "CTRL", action = act.EmitEvent("move-left") },
  -- { key = "l", mods = "CTRL", action = act.EmitEvent("move-right") },
  -- { key = "k", mods = "CTRL", action = act.EmitEvent("move-up") },
  -- { key = "j", mods = "CTRL", action = act.EmitEvent("move-down") },
  -- { key = "v", mods = "LEADER", action = act.SplitHorizontal },
  -- { key = "h", mods = "LEADER", action = act.SplitVertical },
  -- -- Prompt for a name to use for a new workspace and switch to it.
  -- {
  --   key = "N",
  --   mods = "LEADER|SHIFT",
  --   action = act.PromptInputLine({
  --     description = wezterm.format({
  --       { Attribute = { Intensity = "Bold" } },
  --       { Foreground = { AnsiColor = "Fuchsia" } },
  --       { Text = "Enter name for new workspace" },
  --     }),
  --     action = wezterm.action_callback(function(window, pane, line)
  --       -- line will be `nil` if they hit escape without entering anything
  --       -- An empty string if they just hit enter
  --       -- Or the actual line of text they wrote
  --       if line then
  --         window:perform_action(
  --           act.SwitchToWorkspace({
  --             name = line,
  --           }),
  --           pane
  --         )
  --       end
  --     end),
  --   }),
  -- },
  -- {
  --   key = "R",
  --   mods = "LEADER|SHIFT",
  --   action = act.PromptInputLine({
  --     description = wezterm.format({
  --       { Attribute = { Intensity = "Bold" } },
  --       { Foreground = { AnsiColor = "Fuchsia" } },
  --       { Text = "Enter new name for workspace" },
  --     }),
  --     action = wezterm.action_callback(function(window, pane, line)
  --       -- line will be `nil` if they hit escape without entering anything
  --       -- An empty string if they just hit enter
  --       -- Or the actual line of text they wrote
  --       if line then
  --         mux.rename_workspace(window:active_workspace(), line)
  --       end
  --     end),
  --   }),
  -- },
  -- {
  --   key = "S",
  --   mods = "LEADER|SHIFT",
  --   -- action = session_manager.save(),
  --   action = session_manager.save_session(),
  -- },
  -- {
  --   key = "R",
  --   mods = "LEADER|SHIFT",
  --   -- action = session_manager.save(),
  --   action = wezterm.action_callback(function()
  --     session_manager.restore()
  --   end),
  -- },
  -- -- =====================================================================

  -- =====================================================================
  -- TMUX specific keybindings
  -- { key = ".", mods = "CTRL", action = act.SendString("\x1b[46;5u") },
  -- { key = ",", mods = "CTRL", action = act.SendString("\x1b[44;5u") },

  { key = ".", mods = "CTRL", action = act.SendString("þ") },
  { key = ",", mods = "CTRL", action = act.SendString("†") },
  -- This below maps CTRL+; to Ω, since that is a key combination that can be sent to tmux to run the popup with the session switcher
  { key = ";", mods = "CTRL", action = act.SendString("Ω") },
  -- { key = "'", mods = "CTRL", action = act.SendString("þ") },
  -- { key = "\\", mods = "CTRL", action = act.SendString("†") },
  -- =====================================================================

  -- -- =====================================================================
  -- -- zellij specific keybindings
  -- { key = "j", mods = "CTRL", action = act.EmitEvent("zellij-ctrl-j") },
  -- -- =====================================================================
}

-- -- Call the startup preparator!!!!
-- wezterm.on("gui-startup", function()
--   session_manager.restore()
-- end)

return config
