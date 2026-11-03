local util = require("util")

-- COPY MODE JUST LIKE TMUX
-- ###########################################################
-- require("copy_mode")
-- rex.bind("ctrl+/", "copy_mode") -- or any key you like

local P = "ctrl+f>"

-- LAUNCHER MODE TO LAUNCH FLOATING WINDOWS WITH COMMANDS
-- ###########################################################
require("launcher_mode")
-- rex.bind("ctrl+f", "client.mode.enter", { name = "launcher_mode", once = true })
rex.bind(P .. "g", "floating_pane_with_command", { command = { "lazygit" } })
rex.bind(P .. "f", "floating_pane_with_command", { command = { "fish" } })
rex.bind(P .. "shift+r", "client.config.reload", {})
-- rex.bind(P .. "c", "floating_pane_with_command", { command = { "claude" }, bounds = { 0.505, 0.005, 0.49, 0.99 } })
-- rex.bind("launcher_mode/g", "floating_pane_with_command", { command = { "fish", "-C", "lazygit" } })

-- Minimize all floating panes in the active window
rex.bind("ctrl+\\", "pane.minimize_all_floating", {})
-- rex.bind("ctrl+shift+\\", "floating_pane_with_command", { command = { "fish" } })

rex.bind("ctrl+,", "client.tab.previous", {})
rex.bind("ctrl+.", "client.tab.next", {})
rex.bind("ctrl+'", "client.sidebar.activity.toggle", {})

rex.bind("ctrl+;", "client.palette.toggle", {})
-- rex.bind("ctrl+;", "session.switch", {})
-- rex.bind("ctrl+q", "pane.close", {})
rex.bind(P .. "q", "pane.close", {})
-- rex.bind("ctrl+shift+t", "client.tab.rename", {})
-- rex.bind("ctrl+shift+s", "session.rename", {})
rex.bind("ctrl+shift+-", "pane.split", { direction = "down" })
rex.bind("ctrl+shift+=", "pane.split", { direction = "right" })

-- -- Pane navigation that hands the key to (n)vim when it's in front.
-- -- This is a named action rather than a function binding: Rex currently doesn't
-- -- run function bindings when a floating pane has focus, but named actions do.
-- -- Since an action can't "decline" a key like a function returning false, it
-- -- forwards the key to vim itself.
-- rex.action({
--   name = "focus_or_vim",
--   title = "Focus Pane (or send key to vim)",
--   args = { direction = "string", key = "string" },
--   run = function(ctx, args)
--     if util.is_vim(ctx) then
--       rex.client.queue("pane.send_key", { key = args.key })
--     else
--       rex.client.queue("pane.focus", { direction = args.direction })
--     end
--     return true
--   end,
-- })
--
-- for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
--   rex.bind("ctrl+" .. key, "focus_or_vim", { direction = direction, key = "ctrl+" .. key })
-- end

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+shift+" .. key, function(ctx)
    if util.is_vim(ctx) then
      return false
    end
    return util.resize_pane(ctx, direction, 0.02)
  end)
end

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+" .. key, function(ctx)
    if util.is_vim(ctx) then
      return false
    end
    rex.session.focus_direction({ direction = direction })
    return true
  end)
end
