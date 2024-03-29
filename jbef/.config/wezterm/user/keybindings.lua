local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local session_manager = require("user.session-manager")

local M = {}

M.common_keys = {
  { key = "=", mods = "CTRL", action = act.DisableDefaultAssignment },
}

M.tmux_keys = {

  -- This below maps CTRL+; to Ω, since that is a key combination that can be sent to tmux to run the popup with the session switcher
  { key = ";", mods = "CTRL", action = act.SendString("þ") },
  { key = "-", mods = "CTRL", action = act.SendString("Ω") },
  -- { key = "=", mods = "CTRL", action = act.SendString("†") },
  -- =====================================================================
}

M.wezterm_keys = {
  { key = ".", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(1) },
  { key = ",", mods = "CTRL", action = act.ActivateTabRelativeNoWrap(-1) },
  { key = ".", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
  { key = ",", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
  -- { key = ";", mods = "CTRL", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  { key = "-", mods = "CTRL", action = wezterm.action.TogglePaneZoomState },
  { key = "h", mods = "CTRL", action = act.EmitEvent("move-left") },
  { key = "l", mods = "CTRL", action = act.EmitEvent("move-right") },
  { key = "k", mods = "CTRL", action = act.EmitEvent("move-up") },
  { key = "j", mods = "CTRL", action = act.EmitEvent("move-down") },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal },
  { key = "h", mods = "LEADER", action = act.SplitVertical },

  {
    key = "N",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
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
        { Text = "Enter new name for workspace" },
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

  {
    key = "S",
    mods = "LEADER|SHIFT",
    -- action = session_manager.save(),
    action = session_manager.save_session(),
  },
  {
    key = "R",
    mods = "LEADER|SHIFT",
    -- action = session_manager.save(),
    action = wezterm.action_callback(function()
      session_manager.restore()
    end),
  },
}

return M
