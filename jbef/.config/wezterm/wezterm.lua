local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local session_manager = require("user.session-manager")
local palette = require("user.catppuccin").colors.mocha
-- local session_manager = require("user.session-manager-test")

local USE_TMUX = true

local config = {
  term = "wezterm",
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = "Tokyo Night Moon",
}

config.font = wezterm.font({
  family = "FiraCode Nerd Font",
})
config.font_size = 14.0

config.font_rules = {
  -- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html#font_rules
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({
      family = "FiraCode Nerd Font",
      -- family = "Fira Code",
      weight = "Medium",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = "FiraCode Nerd Font",
      -- family = "Fira Code",
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
config.underline_position = -5 -- specific for FiraCode font
config.max_fps = 120
-- config.max_fps = 240
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 0
config.front_end = "WebGpu"
config.webgpu_preferred_adapter = {
  backend = "Metal",
  device = 0,
  device_type = "IntegratedGpu",
  name = "Apple M1 Pro",
  vendor = 0,
}
-- cursor_blink_ease_in = "Constant",
-- cursor_blink_ease_out = "Constant",

config.automatically_reload_config = true
config.use_fancy_tab_bar = false
-- tab_bar_at_bottom = true,
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98
config.macos_window_background_blur = 0
if USE_TMUX then
  config.hide_tab_bar_if_only_one_tab = true
else
  config.hide_tab_bar_if_only_one_tab = false
end
config.tab_max_width = 999

config.command_palette_bg_color = palette.base
config.command_palette_fg_color = palette.overlay2

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

-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=modifiers#keyboard-concepts:~:text=macOS%20Left%20and%20Right%20Option%20Key
config.send_composed_key_when_right_alt_is_pressed = true

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

-- Spawn a fish shell in login mode
-- config.default_prog = { "/opt/homebrew/bin/fish" }
-- config.default_prog = { "/bin/zsh" }

config.inactive_pane_hsb = {
  -- saturation = 0.7,
  saturation = 1.0,
  -- brightness = 0.9,
  brightness = 1.0,
}

config.tab_bar_style = {}
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

config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
  -- local result = wezterm.strftime("%Y-%m-%d %H:%M:%S")
  local cwd_uri = pane:get_current_working_dir()

  local right_separator = "  "
  local separator = " "

  local branch = ""
  local git_info = ""
  -- local datetime = wezterm.strftime("%a %b %-d %H:%M")

  if cwd_uri ~= nil then
    local cwd = cwd_uri.file_path
    local git_dir = "--git-dir=" .. cwd .. "/.git"
    -- local _branch = io.popen("git " .. git_dir .. " branch --show-current")
    -- branch = wezterm.to_string(_branch:read("*a")):gsub('"', ""):gsub("\\n", "")
    -- _branch:close()
    -- local _git_info = io.popen("git " .. git_dir .. " status -s -uno | wc -l")
    -- git_info = tostring(_git_info:read("*a")):gsub("%s", "")
    -- _git_info:close()
    local _, _branch, _ = wezterm.run_child_process({ "git", git_dir, "branch", "--show-current" })
    branch = _branch

    -- local _, _git_info, _ = wezterm.run_child_process({ "git", git_dir, "status", "-s", "-uno" })
    -- local _s, _git_info, _e = wezterm.run_child_process({ "wc", "-l", "<<<", _status_temp })
    -- git_info = _git_info
    -- wezterm.log_info(_git_info)

    -- local _git_info = io.popen("git " .. git_dir .. " status -s -uno | wc -l")
    -- git_info = tostring(_git_info:read("*a")):gsub("%s", "")
    -- _git_info:close()

    -- command = io.popen("git " .. git_dir .. " status -s -uno | wc -l")
    -- local unstaged = tostring(command:read("*a")):gsub("%s", "")
  end

  -- command = io.popen("gitmux -cfg /Users/jbef/.config/tmux/gitmux.conf /Users/jbef/Developer/dotfiles")
  -- local command = io.popen("gitmux /Users/jbef/Developer/dotfiles")
  -- local gitmux_result = wezterm.to_string(command:read("*a"))
  -- command:close()
  window:set_right_status(wezterm.format({
    { Foreground = { Color = palette.green } },
    { Text = "󰘬 " .. branch },
    { Text = separator },
    { Foreground = { Color = palette.subtext0 } },
    { Text = git_info },
    -- { Text = "󰘬 " .. unstaged },
    -- { Text = "󰘬 " .. gitmux_result },
    { Text = right_separator },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- local title = tab.tab_title
  local left_padding = " "
  local separator = " "
  local custom_title = "------"
  local edge_background = palette.base
  local edge_foreground = palette.base
  local background = palette.pink
  local foreground = palette.pink

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
    background = palette.base
    foreground = palette.pink
  else
    background = palette.base
    foreground = palette.surface1
  end

  return {
    { Attribute = { Intensity = "Bold" } },
    -- { Attribute = { Italic = true } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = palette.subtext1 } },
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

local move_around = function(window, pane, direction_wez, direction_nvim)
  if pane:get_title():sub(-4) == "NVIM" then
    window:perform_action(act.SendString(direction_nvim), pane)
  else
    window:perform_action(act.ActivatePaneDirection(direction_wez), pane)
  end
end

if USE_TMUX == false then
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

if USE_TMUX == true then
  config.leader = { key = "b", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
else
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
end

wezterm.on("save_session", function(window)
  session_manager.save_state(window)
end)
-- wezterm.on("load_session", function(window)
--   session_manager.load_state(window)
-- end)
-- wezterm.on("restore_session", function(window)
--   session_manager.restore_state(window)
-- end)

config.keys = {

  -- { key = "S", mods = "LEADER|SHIFT", action = wezterm.action({ EmitEvent = "save_session" }) },
  -- {
  --   key = "L",
  --   mods = "LEADER|SHIFT",
  --   action = wezterm.action_callback(function(window, pane)
  --     -- Lua implementation of PHP scandir function
  --     local directory = wezterm.home_dir .. "/.config/wezterm/wezterm-session-manager/"
  --     local choices, popen = {}, io.popen
  --     local pfile = popen('ls -a "' .. directory .. '"')
  --     for filename in pfile:lines() do
  --       if filename ~= "." and filename ~= ".." then
  --         local val = tostring(filename:gsub(".json", ""):gsub("wezterm_state_", ""):gsub("%s+", ""))
  --         table.insert(choices, { id = val, label = val })
  --       end
  --     end
  --     pfile:close()
  --     window:perform_action(
  --       act.InputSelector({
  --         action = wezterm.action_callback(function(_, _, id, label)
  --           if not id and not label then
  --             wezterm.log_info("cancelled")
  --           else
  --             session_manager.load_state(window, pane, label)
  --           end
  --         end),
  --         title = "I am title",
  --         choices = choices,
  --         alphabet = "",
  --         description = "Write the number you want to choose or press / to search.",
  --       }),
  --       pane
  --     )
  --   end),
  -- },
  -- { key = "n", mods = "CTRL|SHIFT", action = wezterm.action({ EmitEvent = "restore_session" }) },

  { key = "Space", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
}

if USE_TMUX then
  for _, k in pairs(require("user.keybindings").tmux_keys) do
    table.insert(config.keys, k)
  end
else
  for _, k in pairs(require("user.keybindings").wezterm_keys) do
    table.insert(config.keys, k)
  end
end

-- -- Call the startup preparator!!!!
-- wezterm.on("gui-startup", function()
--   session_manager.restore()
-- end)

return config
