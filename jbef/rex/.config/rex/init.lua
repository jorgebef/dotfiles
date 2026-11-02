local util = require("util")

-- COPY MODE JUST LIKE TMUX
-- ###########################################################
-- require("copy_mode")
-- rex.bind("ctrl+/", "copy_mode") -- or any key you like

-- LAUNCHER MODE TO LAUNCH FLOATING WINDOWS WITH COMMANDS
-- ###########################################################
require("launcher_mode")
rex.bind("ctrl+f", "client.mode.enter", { name = "launcher_mode", once = true })
rex.bind("launcher_mode/c", "floating_pane_with_command", { command = { "claude", "--resume" } })
rex.bind("launcher_mode/g", "floating_pane_with_command", { command = { "fish", "-C", "lazygit" } })
rex.bind("launcher_mode/f", "floating_pane_with_command", { command = { "fish" } })
-- rex.bind("launcher_mode/g", "floating_pane_with_command", { command = { "fish", "-C", "lazygit" } })

-- Minimize all floating panes in the active window
-- rex.bind("ctrl+\\", "pane.minimize_all_floating", {})
-- rex.bind("ctrl+shift+\\", "floating_pane_with_command", { command = { "fish" } })

rex.bind("ctrl+,", "client.tab.previous", {})
rex.bind("ctrl+.", "client.tab.next", {})
rex.bind("ctrl+\\", "client.sidebar.activity.toggle", {})

rex.bind("ctrl+;", "client.palette.toggle", {})
-- rex.bind("ctrl+;", "session.switch", {})
rex.bind("ctrl+q", "pane.close", {})
-- rex.bind("ctrl+shift+t", "client.tab.rename", {})
-- rex.bind("ctrl+shift+s", "session.rename", {})
rex.bind("ctrl+shift+-", "pane.split", { direction = "down" })
rex.bind("ctrl+shift+=", "pane.split", { direction = "right" })

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+" .. key, function(ctx)
    if util.is_vim(ctx) then
      return false
    end
    rex.session.focus_direction({ direction = direction })
    return true
  end)
end
