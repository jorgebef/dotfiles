local util = require("util")
require("actions")

-- COPY MODE JUST LIKE TMUX
-- ###########################################################
-- require("copy_mode")
-- rex.bind("ctrl+/", "copy_mode") -- or any key you like

local P = "ctrl+s>"

-- LAUNCHER MODE TO LAUNCH FLOATING WINDOWS WITH COMMANDS
-- ###########################################################
-- rex.bind("ctrl+f", "client.mode.enter", { name = "launcher_mode", once = true })
rex.bind(P .. "g", "floating_pane_with_command", { command = { "lazygit" } })
rex.bind(P .. "f", "floating_pane_with_command", { command = { "fish" } })
-- rex.bind("ctrl+s", "floating_pane_with_command", { command = { "fish" } })
rex.bind(P .. "shift+r", "client.config.reload", {})
rex.bind(P .. "c", "split_pane_with_command", { command = { "claude" }, ratio = 0.7 })
-- rex.bind(P .. "c", "floating_pane_with_command", { command = { "claude" }, bounds = { 0.645, 0.005, 0.35, 0.99 } })
-- rex.bind("launcher_mode/g", "floating_pane_with_command", { command = { "fish", "-C", "lazygit" } })

-- rex.bind(P .. "c", "floating_pane_with_command", { command = { "claude" }, bounds = { 0.505, 0.005, 0.49, 0.99 } })

-- Minimize all floating panes in the active window
rex.bind("ctrl+\\", "pane.minimize_all_floating", {})
-- rex.bind("ctrl+shift+\\", "floating_pane_with_command", { command = { "fish" } })

rex.bind("ctrl+,", "client.tab.previous", {})
rex.bind("ctrl+.", "client.tab.next", {})

-- Go to tab N with ctrl+N (instead of the default cmd+N)
for i = 1, 9 do
  rex.bind("ctrl+" .. i, "client.tab.goto", { index = i })
end

rex.bind("ctrl+'", "client.sidebar.activity.toggle", {})
rex.bind("ctrl+enter", "pane.zoom", {})

rex.bind("ctrl+;", "pane.go_to", {})
-- rex.bind("ctrl+;", "session.switch", {})
rex.bind(P .. "q", "pane.close", {})
-- rex.bind(P .. "q", "pane.close", {})
-- rex.bind("ctrl+shift+t", "client.tab.rename", {})
-- rex.bind("ctrl+shift+s", "session.rename", {})
rex.bind(P .. "h", "pane.split", { direction = "down" })
rex.bind(P .. "v", "pane.split", { direction = "right" })

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+shift+" .. key, function(ctx)
    if util.is_vim(ctx) then
      -- Send the key straight to the pane; block.event skips Lua bindings, so it won't loop back here
      for _, action in ipairs({ "press", "release" }) do
        rex.call("block.event", {
          session_id = ctx.session_id or rex.session_id,
          block_id = ctx.block_id,
          event = {
            type = "key",
            payload = {
              key = "key_" .. key,
              mods = "shift+ctrl",
              consumed_mods = "",
              text = "",
              unshifted_codepoint = string.byte(key),
              composing = false,
              action = action,
            },
          },
        })
      end
      return true
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

-- local nvim_process_names = { nvim = true, vim = true, vi = true, vimdiff = true, nvimdiff = true }
--
-- local function is_nvim_foreground(process)
--   if not process then
--     return false
--   end
--   -- `name` isn't always the executable (e.g. claude reports its version), so
--   -- check argv0 and path as well.
--   for _, executable in ipairs({ process.name, process.argv0, process.path }) do
--     if type(executable) == "string" then
--       local name = (executable:match("([^/]+)$") or executable):lower():gsub("^%-", "")
--       if nvim_process_names[name] then
--         return true
--       end
--     end
--   end
--   return false
-- end
--
-- local function active_window(view)
--   for _, window in ipairs(view.windows or {}) do
--     if window.window_id == view.active_window_id then
--       return window
--     end
--   end
--   return nil
-- end
--
-- local function collect_layout_blocks(node, layer, blocks)
--   if not node then
--     return
--   end
--   if node.block_id and node.rect then
--     blocks[#blocks + 1] = { block_id = node.block_id, rect = node.rect, layer = layer }
--     return
--   end
--   if node.split then
--     collect_layout_blocks(node.split.before, layer, blocks)
--     collect_layout_blocks(node.split.after, layer, blocks)
--   end
-- end
--
-- -- Every pane you can see in the window, back to front: the tiled layout, then
-- -- floating panes that aren't minimized (later layers are in front). Rects are
-- -- { x, y, w, h } as fractions of the window, for floating panes too.
-- local function visible_blocks(window)
--   local blocks = {}
--   for _, layer in ipairs(window.layers or {}) do
--     if layer.layout and layer.state ~= "minimized" then
--       collect_layout_blocks(layer.layout, layer, blocks)
--     end
--   end
--   return blocks
-- end
--
-- -- The pane drawn at a point of the window: the frontmost one covering it.
-- local function pane_at(blocks, x, y)
--   for i = #blocks, 1, -1 do
--     local rx, ry, rw, rh = unpack(blocks[i].rect)
--     if x >= rx and x < rx + rw and y >= ry and y < ry + rh then
--       return blocks[i]
--     end
--   end
--   return nil
-- end
--
-- local RAYS = 32 -- rays cast across the focused pane
-- local RAY_STEP = 0.002 -- how far a ray moves per check, as a fraction of the window
--
-- -- The pane next to the focused one in `direction`, whether tiled or floating.
-- --
-- -- It casts parallel rays from the focused pane's center line in `direction`,
-- -- spread across the pane, and follows each one until it reaches a pane drawn
-- -- there that isn't the focused one. The pane most rays reach wins (on a tie,
-- -- the first one along the pane), so it's the one sharing the most visible
-- -- border, like tmux. Going by what's drawn means a floating pane wins over the
-- -- tiled pane under it, and a float sitting inside a tiled pane is reachable
-- -- from it. A pane already drawn where a ray starts sits on top of the focused
-- -- pane rather than beside it, so that ray passes through it.
-- local function nearest_pane(window, focused_block_id, direction)
--   local blocks = visible_blocks(window)
--
--   local source
--   for _, block in ipairs(blocks) do
--     if block.block_id == focused_block_id then
--       source = block
--       break
--     end
--   end
--   if not source then
--     return nil
--   end
--
--   local sx, sy, sw, sh = unpack(source.rect)
--   local horizontal = direction == "left" or direction == "right"
--   local sign = (direction == "right" or direction == "down") and 1 or -1
--   local start, span_start, span_length = sx + sw / 2, sy, sh
--   if not horizontal then
--     start, span_start, span_length = sy + sh / 2, sx, sw
--   end
--
--   local function point(along_ray, across)
--     if horizontal then
--       return along_ray, across
--     end
--     return across, along_ray
--   end
--
--   local hits, best = {}, nil
--   for i = 0, RAYS - 1 do
--     local across = span_start + span_length * (i + 0.5) / RAYS
--     local covering = pane_at(blocks, point(start, across))
--     local position = start + sign * RAY_STEP
--     while position >= 0 and position < 1 do
--       local pane = pane_at(blocks, point(position, across))
--       if pane and pane ~= source and pane ~= covering then
--         hits[pane] = (hits[pane] or 0) + 1
--         if not best or hits[pane] > hits[best] then
--           best = pane
--         end
--         break
--       end
--       position = position + sign * RAY_STEP
--     end
--   end
--   return best
-- end
--
-- local function focus_adjacent_pane(session_id, block_id, direction)
--   local view, view_error = rex.session.view({ session_id = session_id })
--   if not view then
--     return nil, view_error
--   end
--   local window = active_window(view)
--   if not window then
--     return nil, "no active window"
--   end
--
--   local target = nearest_pane(window, block_id or window.focused_block_id, direction)
--   if not target then
--     return true -- nothing that way; stay put
--   end
--
--   local ok, err = rex.session.focus_block({ session_id = session_id, block_id = target.block_id })
--   if ok and target.layer.kind == "floating" then
--     -- focus_block doesn't bring a floating pane to the front
--     rex.call("session.raise_layer", { session_id = session_id, layer_id = target.layer.layer_id })
--   end
--   return ok, err
-- end
--
-- local function block_runs_nvim(session_id, block_id)
--   local process, process_error = rex.call("block.method", {
--     session_id = session_id,
--     block_id = block_id,
--     method = "process",
--   })
--   if process and is_nvim_foreground(process.foreground) then
--     return true
--   end
--   if not process and process_error then
--     rex.log("warn", "pane navigation: process lookup failed: " .. tostring(process_error))
--   end
--
--   local title = rex.call("block.method", {
--     session_id = session_id,
--     block_id = block_id,
--     method = "title",
--   })
--   return title ~= nil and type(title.title) == "string" and title.title:lower() == "nvim"
-- end
--
-- -- Send ctrl+<letter> straight to the pane. block.event skips Lua bindings, so
-- -- it doesn't loop back into this action.
-- local function send_ctrl_key(session_id, block_id, letter)
--   for _, action in ipairs({ "press", "release" }) do
--     rex.call("block.event", {
--       session_id = session_id,
--       block_id = block_id,
--       event = {
--         type = "key",
--         payload = {
--           key = "key_" .. letter,
--           mods = "ctrl",
--           consumed_mods = "",
--           text = "",
--           unshifted_codepoint = string.byte(letter),
--           composing = false,
--           action = action,
--         },
--       },
--     })
--   end
-- end
--
-- -- Move to the nearest pane (tiled or floating) in a direction, or hand the key
-- -- to (n)vim when it's in front so smart-splits can handle it.
-- --
-- -- This is a named action rather than a function binding because Rex doesn't
-- -- run function bindings while a floating pane has focus (open Rex bug). An
-- -- action can't decline a key the way a function returning false does, so it
-- -- forwards the key to vim itself.
-- rex.action({
--   name = "focus_pane_or_vim",
--   title = "Focus Pane (or send key to vim)",
--   args = { direction = "string", key = "string" },
--   run = function(ctx, args)
--     local session_id = ctx.session_id or rex.session_id
--     local block_id = util.focused_block(ctx)
--     if not session_id or not block_id then
--       return true
--     end
--
--     if block_runs_nvim(session_id, block_id) then
--       send_ctrl_key(session_id, block_id, args.key)
--       return true
--     end
--
--     local ok, err = focus_adjacent_pane(session_id, block_id, args.direction)
--     if not ok then
--       rex.log("warn", "pane navigation: focus failed: " .. tostring(err))
--     end
--     return true
--   end,
-- })
--
-- for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
--   rex.bind("ctrl+" .. key, "focus_pane_or_vim", { direction = direction, key = key })
-- end
