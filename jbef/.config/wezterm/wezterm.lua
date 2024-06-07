local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
-- local palette = require("user.catppuccin").colors.mocha

package.path = package.path .. ";/Users/jbef/.config/colors/?.lua"
local kanagawa_custom = require("kanagawa-custom")

local USE_TMUX = true

local config = wezterm.config_builder()

config.term = "wezterm"

config.colors = {
  foreground = kanagawa_custom.fujiWhite,
  background = kanagawa_custom.sumiInk3,
  cursor_bg = kanagawa_custom.fujiWhite,
  cursor_fg = kanagawa_custom.sumiInk0,
  cursor_border = kanagawa_custom.oldWhite,
  selection_fg = kanagawa_custom.oldWhite,
  selection_bg = kanagawa_custom.waveBlue2,
  scrollbar_thumb = kanagawa_custom.sumiInk0,
  split = kanagawa_custom.sumiInk0,
  ansi = {
    kanagawa_custom.sumiInk0,
    kanagawa_custom.autumnRed,
    kanagawa_custom.autumnGreen,
    kanagawa_custom.boatYellow2,
    kanagawa_custom.crystalBlue,
    kanagawa_custom.oniViolet,
    kanagawa_custom.waveAqua1,
    kanagawa_custom.oldWhite,
  },
  brights = {
    kanagawa_custom.fujiGray,
    kanagawa_custom.samuraiRed,
    kanagawa_custom.springGreen,
    kanagawa_custom.carpYellow,
    kanagawa_custom.springBlue,
    kanagawa_custom.springViolet1,
    kanagawa_custom.waveAqua2,
    kanagawa_custom.lotusGray,
  },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Kanagawa (Gogh)"

config.font = wezterm.font({
  family = "JetbrainsMono Nerd Font",
})
config.font_size = 14.5

config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({
      family = "JetBrainsMono Nerd Font",
      weight = "Medium",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = "JetBrainsMono Nerd Font",
      weight = "Medium",
      italic = true,
    }),
  },
}
-- Disables ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
-- config.line_height = 1.05 -- specific for FiraCode font
config.underline_thickness = 2 -- specific for FiraCode font
config.underline_position = -6 -- specific for FiraCode font
config.max_fps = 120
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 0

-- config.front_end = "WebGpu"
config.front_end = "OpenGL"
-- config.webgpu_preferred_adapter = {
--   backend = "Metal",
--   device = 0,
--   device_type = "IntegratedGpu",
--   name = "Apple M1 Pro",
--   vendor = 0,
-- }

config.automatically_reload_config = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 1
config.window_background_opacity = 0.98
config.macos_window_background_blur = 0
if USE_TMUX then
  config.hide_tab_bar_if_only_one_tab = true
else
  config.hide_tab_bar_if_only_one_tab = false
end
-- config.tab_max_width = 999

-- config.command_palette_bg_color = palette.base
-- config.command_palette_fg_color = palette.overlay2

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

-- config.tab_bar_style = {}
-- config.show_new_tab_button_in_tab_bar = false
-- config.colors = {
--   split = "#585b70",
--   tab_bar = {
--     -- The color of the strip that goes along the top of the window
--     -- (does not apply when fancy tab bar is in use)
--     background = "#1E1E2E",
--   },
-- }

config.status_update_interval = 1000
-- config.status_update_interval = 0

-- wezterm.on("update-right-status", function(window, pane)
--   -- local result = wezterm.strftime("%Y-%m-%d %H:%M:%S")
--   local cwd_uri = pane:get_current_working_dir()
--
--   local right_separator = "  "
--   local separator = " "
--
--   local branch = ""
--   local git_info = ""
--   -- local datetime = wezterm.strftime("%a %b %-d %H:%M")
--
--   if cwd_uri ~= nil then
--     local cwd = cwd_uri.file_path
--     local git_dir = "--git-dir=" .. cwd .. "/.git"
--     -- local _branch = io.popen("git " .. git_dir .. " branch --show-current")
--     -- branch = wezterm.to_string(_branch:read("*a")):gsub('"', ""):gsub("\\n", "")
--     -- _branch:close()
--     -- local _git_info = io.popen("git " .. git_dir .. " status -s -uno | wc -l")
--     -- git_info = tostring(_git_info:read("*a")):gsub("%s", "")
--     -- _git_info:close()
--     local _, _branch, _ = wezterm.run_child_process({ "git", git_dir, "branch", "--show-current" })
--     branch = _branch
--   end
--
--   -- command = io.popen("gitmux -cfg /Users/jbef/.config/tmux/gitmux.conf /Users/jbef/Developer/dotfiles")
--   -- local command = io.popen("gitmux /Users/jbef/Developer/dotfiles")
--   -- local gitmux_result = wezterm.to_string(command:read("*a"))
--   -- command:close()
--   window:set_right_status(wezterm.format({
--     { Foreground = { Color = palette.green } },
--     { Text = "󰘬 " .. branch },
--     { Text = separator },
--     { Foreground = { Color = palette.subtext0 } },
--     { Text = git_info },
--     -- { Text = "󰘬 " .. unstaged },
--     -- { Text = "󰘬 " .. gitmux_result },
--     { Text = right_separator },
--   }))
-- end)

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   -- local title = tab.tab_title
--   local left_padding = " "
--   local separator = " "
--   local custom_title = "------"
--   local edge_background = palette.base
--   local edge_foreground = palette.base
--   local background = palette.pink
--   local foreground = palette.pink
--
--   local mux_window = mux.get_window(tab.window_id)
--   local workspace = "  " .. mux:get_active_workspace()
--   local mux_tab = mux_window:active_tab()
--   local mux_tab_cols = mux_tab:get_size().cols
--
--   -- local window = mux.get_window(tab.window_id)
--   -- local window_dimensions = window:gui_window():get_dimensions()
--
--   if tab.tab_index == 0 then
--     left_padding = workspace
--       .. string.rep(
--         " ",
--         math.floor(
--           (mux_tab_cols - math.floor(#workspace * 2) - #tabs * math.floor(#custom_title) - (#tabs - 1) * #separator) / 2
--         )
--       )
--   end
--
--   if tab.is_active then
--     background = palette.base
--     foreground = palette.pink
--   else
--     background = palette.base
--     foreground = palette.surface1
--   end
--
--   return {
--     { Attribute = { Intensity = "Bold" } },
--     -- { Attribute = { Italic = true } },
--     { Background = { Color = edge_background } },
--     { Foreground = { Color = palette.subtext1 } },
--     { Text = left_padding },
--     { Background = { Color = background } },
--     { Foreground = { Color = foreground } },
--     { Attribute = { Italic = false } },
--     { Text = custom_title },
--     { Background = { Color = edge_background } },
--     { Foreground = { Color = edge_foreground } },
--     { Text = separator },
--   }
-- end)

-- ==================================================================================
-- This is to allow to write ´ when pressint ALT+e on macos and ˜ when pressing ALT+n
-- just like on any other software!!
-- These are called dead keys, and they are composable, which means that after
-- pressing ALT+e, then you need to press the corresponding vowel to produce the
-- desired letter, which is essential in Español!!
-- ==================================================================================
config.send_composed_key_when_left_alt_is_pressed = true
-- ==================================================================================

-- local move_around = function(window, pane, direction_wez, direction_nvim)
--   if pane:get_title():sub(-4) == "NVIM" then
--     window:perform_action(act.SendString(direction_nvim), pane)
--   else
--     window:perform_action(act.ActivatePaneDirection(direction_wez), pane)
--   end
-- end

-- if USE_TMUX == false then
--   wezterm.on("move-left", function(window, pane)
--     move_around(window, pane, "Left", "\x08") -- for nvim, use unicode to send Ctrl+h
--   end)
--   wezterm.on("move-right", function(window, pane)
--     move_around(window, pane, "Right", "\x0C") -- for nvim, use unicode to send Ctrl+l
--   end)
--   wezterm.on("move-up", function(window, pane)
--     move_around(window, pane, "Up", "\x0B") -- for nvim, use unicode to send Ctrl+k
--   end)
--   wezterm.on("move-down", function(window, pane)
--     move_around(window, pane, "Down", "\x0A") -- for nvim, use unicode to send Ctrl+j
--   end)
-- end

-- ==================================================================================
-- Here we set the leader based on whether we have set the flag USE_TMUX or not
-- ==================================================================================
if USE_TMUX == true then
  config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
else
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
end
-- ==================================================================================

-- ==================================================================================
-- Here we set the keybindings depending on whether we USE_TMUX or not
-- ==================================================================================
config.keys = {}

-- Common keymaps whether using TMUX or not
for _, k in pairs(require("user.keybindings").common_keys) do
  table.insert(config.keys, k)
end

-- Keymaps specific to using TMUX or not
if USE_TMUX then
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
