local wezterm = require("wezterm")
local sessionizer = require("user.sessionizer")
local act = wezterm.action
local mux = wezterm.mux

local M = {}

if wezterm.config_builder then
  M.config = wezterm.config_builder()
end
local USE_MULTIPLEXER = true

local new_sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
new_sessionizer.apply_to_config(M.config, true)

-- you can also list multiple paths
new_sessionizer.config.paths = "/Users/jbef/Developer/Clients"

M.config.keys = {
  {
    key = "'",
    mods = "CTRL",
    action = new_sessionizer.show,
  },
  {
    key = "r",
    mods = "ALT|SHIFT",
    action = new_sessionizer.switch_to_most_recent,
  },
}

M.config.term = "wezterm"

-- Configuring domains for persistence across windows using the mux
M.config.unix_domains = {
  {
    name = "jbef.mbp16",
  },
}
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html

if USE_MULTIPLEXER == false then
  M.config.default_domain = "jbef.mbp16"
end

local function isViProcess(pane)
  local prog = pane:get_user_vars()["WEZTERM_PROG"]
  return prog:match("^nvim") or prog:match("^v")
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      wezterm.action.SendKey({ key = vim_direction, mods = "CTRL" }),
      pane
    )
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditionalActivatePane(window, pane, "Down", "j")
end)

-- config.color_scheme = "Catppuccin Mocha"
M.config.colors = require("user.nordic").colors
-- config.colors = require("user.kanagawa-dragon").colors
-- config.colors = require("user.kanagawa-groove").colors
-- config.color_scheme = "nordfox"

M.config.font = wezterm.font({
  family = "Jetbrains Mono",
})
M.config.font_size = 14.5
-- config.cell_width = 1.05

-- config.font_rules = {
--   {
--     intensity = "Bold",
--     italic = false,
--     font = wezterm.font_with_fallback({
--       family = "JetBrainsMono Nerd Font",
--       weight = "Bold",
--     }),
--   },
--   {
--     intensity = "Bold",
--     italic = true,
--     font = wezterm.font_with_fallback({
--       family = "JetBrainsMono Nerd Font",
--       weight = "Medium",
--       italic = true,
--     }),
--   },
-- }

-- Disables ligatures
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
-- config.line_height = 1.05 -- specific for FiraCode font
M.config.underline_thickness = 2 -- specific for FiraCode font
M.config.underline_position = -6 -- specific for FiraCode font
-- config.max_fps = 120
M.config.max_fps = 240
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
-- config.animation_fps = 120

M.config.automatically_reload_config = true
M.config.use_fancy_tab_bar = false
M.config.tab_bar_at_bottom = true
M.config.window_decorations = "RESIZE"
M.config.window_background_opacity = 1
-- config.window_background_opacity = 0.98
-- config.macos_window_background_blur = 0
if USE_MULTIPLEXER then
  M.config.hide_tab_bar_if_only_one_tab = true
else
  M.config.hide_tab_bar_if_only_one_tab = false
end

M.config.window_padding = {
  left = 5,
  right = 5,
  top = 10,
  bottom = 0,
}

-- Enable CSI u mode
-- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
-- This enables using C-. and C-, as keybindings in TMUX for example
M.config.enable_csi_u_key_encoding = true
M.config.disable_default_key_bindings = false
M.config.hide_mouse_cursor_when_typing = true
M.config.cursor_blink_rate = 0

M.config.mouse_bindings = {
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
}

M.config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

M.config.status_update_interval = 1000
-- config.status_update_interval = 0

-- ==================================================================================
-- This is to allow to write ´ when pressint ALT+e on macos and ˜ when pressing ALT+n
-- just like on any other software!!
-- These are called dead keys, and they are composable, which means that after
-- pressing ALT+e, then you need to press the corresponding vowel to produce the
-- desired letter, which is essential in Español!!
-- ==================================================================================
M.config.send_composed_key_when_left_alt_is_pressed = true
-- ==================================================================================

local move_around = function(window, pane, direction_wez, direction_nvim)
  if pane:get_title():sub(-4) == "NVIM" then
    window:perform_action(act.SendString(direction_nvim), pane)
  else
    window:perform_action(act.ActivatePaneDirection(direction_wez), pane)
  end
end

if USE_MULTIPLEXER == false then
  wezterm.on("move-left", function(window, pane)
    move_around(window, pane, "Left", "\x08") -- for nvim, use unicode to send Ctrl+h
  end)
  wezterm.on("move-right", function(window, pane)
    move_around(window, pane, "Right", "\x0C") -- for nvim, use unicode to send Ctrl+l
  end)
  wezterm.on("move-up", function(window, pane)
    move_around(window, pane, "Up", "\x0B") -- for nvim, use unicode to send Ctrl+k
  end)
  wezterm.on("move-down", function(window, pane)
    move_around(window, pane, "Down", "\x0A") -- for nvim, use unicode to send Ctrl+j
  end)
end

-- ==================================================================================
-- Here we set the leader based on whether we have set the flag USE_MULTIPLEXER or not
-- ==================================================================================
if USE_MULTIPLEXER then
  M.config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
else
  M.config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
end
-- ==================================================================================

-- ==================================================================================
-- Here we set the keybindings depending on whether we USE_MULTIPLEXER or not
-- ==================================================================================

M.common_keys = {
  -- { key = "Space", mods = "CTRL|SHIFT", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
  { key = "=", mods = "CTRL", action = act.DisableDefaultAssignment },
  -- { key = "'", mods = "ALT", action = act.SendString("\xc3\xa4") },
  -- { key = "Space", mods = "CTRL|SHIFT", action = wezterm.action_callback(sessionizer.resetCacheAndToggle) },
  -- { key = "'", mods = "CTRL", action = new_sessionizer.show },

  -- { key = "/", mods = "CTRL", action = act.SplitVertical },
  -- { key = "'", mods = "CTRL", action = act.SplitHorizontal },
}

M.tmux_keys = {
  -- This below maps CTRL+; to Ω, since that is a key combination that can be sent to tmux to run the popup with the session switcher
  { key = ";", mods = "CTRL", action = act.SendString("þ") },
  { key = "m", mods = "CTRL", action = act.SendString("Ω") },
  { key = "=", mods = "CTRL", action = act.SendString("†") },

  { key = "h", mods = "CTRL|SHIFT", action = act.SendString("⇇") },
  { key = "j", mods = "CTRL|SHIFT", action = act.SendString("⇊") },
  { key = "k", mods = "CTRL|SHIFT", action = act.SendString("⇈") },
  { key = "l", mods = "CTRL|SHIFT", action = act.SendString("⇉") },
  -- =====================================================================
}

M.wezterm_multiplex_keys = {
  -- Attach to muxer
  { key = ";", mods = "CTRL", action = wezterm.action_callback(sessionizer.open) },
  {
    key = "a",
    mods = "LEADER",
    action = act.AttachDomain("jbp.mbp16"),
  },

  -- Detach from muxer
  {
    key = "d",
    mods = "LEADER",
    action = act.DetachDomain({ DomainName = "jbp.mbp16" }),
  },

  { key = ".", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(1) },
  { key = ",", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(-1) },
  { key = ".", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
  { key = ",", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
  -- { key = ";", mods = "CTRL", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "m", mods = "CTRL", action = wezterm.action.TogglePaneZoomState },
  -- Custom navigation
  { key = "h", mods = "CTRL", action = act.EmitEvent("move-left") },
  { key = "l", mods = "CTRL", action = act.EmitEvent("move-right") },
  { key = "k", mods = "CTRL", action = act.EmitEvent("move-up") },
  { key = "j", mods = "CTRL", action = act.EmitEvent("move-down") },

  { key = "v", mods = "LEADER", action = act.SplitHorizontal },
  { key = "h", mods = "LEADER", action = act.SplitVertical },

  {
    key = "T",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter new name for Tab:" },
      }),
      action = wezterm.action_callback(function(win, _, line)
        if line then
          local tab = win:active_tab()
          tab:set_title(line)
        end
      end),
    }),
  },

  {
    key = "N",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace:" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace({
              name = line,
            }),
            pane
          )
        end
      end),
    }),
  },
  {
    key = "R",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter new name for current workspace:" },
      }),
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          mux.rename_workspace(window:active_workspace(), line)
        end
      end),
    }),
  },
}

-- Common keymaps whether using TMUX or not
for _, k in pairs(M.common_keys) do
  table.insert(M.config.keys, k)
end

-- Keymaps specific to using TMUX or not
if USE_MULTIPLEXER then
  for _, k in pairs(M.tmux_keys) do
    table.insert(M.config.keys, k)
  end
else
  for _, k in pairs(M.wezterm_multiplex_keys) do
    table.insert(M.config.keys, k)
  end
end
-- ==================================================================================

return M.config
