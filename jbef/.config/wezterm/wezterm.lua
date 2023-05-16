local wezterm = require("wezterm")

local config = {
  term = "wezterm",
  color_scheme = "Catppuccin Mocha",

  -- font = wezterm.font({ family = "JetBrainsMono Nerd Font" }),
  font = wezterm.font({ family = "JetBrains Mono" }),
  font_size = 15.0,
  font_rules = {
    -- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html#font_rules
    {
      intensity = "Bold",
      italic = false,
      -- font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold" }),
      font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
    },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font({
        -- family = "JetBrainsMono Nerd Font",
        family = "JetBrains Mono",
        weight = "Bold",
        italic = true,
      }),
    },
  },
  -- Disables ligatures
  -- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  underline_thickness = 2,
  max_fps = 120,

  automatically_reload_config = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_decorations = "RESIZE",
  -- window_background_opacity = 0.9,
  -- macos_window_background_blur = 70,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 5,
    right = 5,
    top = 10,
    bottom = 10,
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

  keys = {
    { key = ".", mods = "CTRL", action = wezterm.action.SendString("\x1b[46;5u") },
    { key = ",", mods = "CTRL", action = wezterm.action.SendString("\x1b[44;5u") },
    -- This below maps CTRL+; to Ω, since that is a key combination that can be sent to tmux to run the popup with the session switcher
    { key = ";", mods = "CTRL", action = wezterm.action.SendString("Ω") },
  },
  mouse_bindings = {
    {
      -- Change the default click behavior so that it only selects
      -- text and doesn't open hyperlinks
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
    },

    -- and make CMD-Click open hyperlinks
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}

return config
