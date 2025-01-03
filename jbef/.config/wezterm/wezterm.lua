local wezterm = require("wezterm")

local act = wezterm.action
-- local palette = require("user.catppuccin").colors.mocha

local USE_MULTIPLEXER = false
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local new_sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
new_sessionizer.apply_to_config(config, true)

-- you can also list multiple paths
new_sessionizer.config.paths = "/Users/jbef/Developer/Clients"

config.keys = {
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

config.term = "wezterm"

-- Configuring domains for persistence across windows using the mux
config.unix_domains = {
  {
    name = "jbef.mbp16",
  },
}
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html

if USE_MULTIPLEXER == false then
  config.default_domain = "jbef.mbp16"
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
-- config.colors = require("user.nordic").colors
-- config.colors = require("user.kanagawa-dragon").colors
config.colors = require("user.kanagawa-groove").colors
-- config.color_scheme = "Kanagawa (Gogh)"

config.font = wezterm.font({
  family = "JetbrainsMono Nerd Font",
})
config.font_size = 14.5

config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font_with_fallback({
      family = "JetBrainsMono Nerd Font",
      weight = "Bold",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font_with_fallback({
      family = "JetBrainsMono Nerd Font",
      weight = "Medium",
      italic = true,
    }),
  },
}
-- Disables ligatures
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
-- config.line_height = 1.05 -- specific for FiraCode font
config.underline_thickness = 2 -- specific for FiraCode font
config.underline_position = -6 -- specific for FiraCode font
-- config.max_fps = 120
config.max_fps = 240
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"
-- config.animation_fps = 120

config.automatically_reload_config = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
-- config.window_background_opacity = 0.98
-- config.macos_window_background_blur = 0
if USE_MULTIPLEXER then
  config.hide_tab_bar_if_only_one_tab = true
else
  config.hide_tab_bar_if_only_one_tab = false
end

config.window_padding = {
  left = 5,
  right = 5,
  top = 10,
  bottom = 0,
}

-- Enable CSI u mode
-- https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
-- This enables using C-. and C-, as keybindings in TMUX for example
config.enable_csi_u_key_encoding = true
config.disable_default_key_bindings = false
config.hide_mouse_cursor_when_typing = true
config.cursor_blink_rate = 0

config.mouse_bindings = {
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

config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- -- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.status_update_interval = 1000
-- config.status_update_interval = 0

-- ==================================================================================
-- This is to allow to write ´ when pressint ALT+e on macos and ˜ when pressing ALT+n
-- just like on any other software!!
-- These are called dead keys, and they are composable, which means that after
-- pressing ALT+e, then you need to press the corresponding vowel to produce the
-- desired letter, which is essential in Español!!
-- ==================================================================================
config.send_composed_key_when_left_alt_is_pressed = true
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
  config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
else
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
end
-- ==================================================================================

-- ==================================================================================
-- Here we set the keybindings depending on whether we USE_MULTIPLEXER or not
-- ==================================================================================

-- Common keymaps whether using TMUX or not
for _, k in pairs(require("user.keybindings").common_keys) do
  table.insert(config.keys, k)
end

-- Keymaps specific to using TMUX or not
if USE_MULTIPLEXER then
  for _, k in pairs(require("user.keybindings").tmux_keys) do
    table.insert(config.keys, k)
  end
else
  for _, k in pairs(require("user.keybindings").wezterm_keys) do
    table.insert(config.keys, k)
  end
end
-- ==================================================================================

return config
