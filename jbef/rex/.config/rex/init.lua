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

rex.bind("ctrl+;", "client.palette.toggle", {})
-- rex.bind("ctrl+;", "session.switch", {})
rex.bind("ctrl+shift+q", "pane.close", {})
-- rex.bind(P .. "q", "pane.close", {})
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

-- for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
--   rex.bind("ctrl+" .. key, function(ctx)
--     if util.is_vim(ctx) then
--       return false
--     end
--     rex.session.focus_direction({ direction = direction })
--     return true
--   end)
-- end

local function is_nvim_foreground(process)
  if not process then
    return false
  end
  local executable = process.name or process.argv0 or process.path
  if type(executable) ~= "string" then
    return false
  end
  local name = (executable:match("([^/]+)$") or executable):lower():gsub("^%-", "")
  return nvim_process_names[name] == true
end

local layout_epsilon = 0.000001

local function active_window(view)
  for _, window in ipairs(view.windows or {}) do
    if window.window_id == view.active_window_id then
      return window
    end
  end
  return nil
end

local function collect_layout_blocks(node, blocks)
  if node.block_id and node.rect then
    blocks[#blocks + 1] = { block_id = node.block_id, rect = node.rect }
    return
  end
  if not node.split then
    return
  end
  collect_layout_blocks(node.split.before, blocks)
  collect_layout_blocks(node.split.after, blocks)
end

local function adjacent_pane_distance(source, candidate, direction)
  local source_x, source_y, source_width, source_height = unpack(source.rect)
  local candidate_x, candidate_y, candidate_width, candidate_height = unpack(candidate.rect)
  if direction == "up" or direction == "down" then
    local overlap = math.min(source_x + source_width, candidate_x + candidate_width) - math.max(source_x, candidate_x)
    if overlap <= layout_epsilon then
      return nil
    end
    if direction == "up" then
      local distance = source_y - (candidate_y + candidate_height)
      if distance >= -layout_epsilon then
        return math.max(0, distance), overlap
      end
    else
      local distance = candidate_y - (source_y + source_height)
      if distance >= -layout_epsilon then
        return math.max(0, distance), overlap
      end
    end
    return nil
  end

  local overlap = math.min(source_y + source_height, candidate_y + candidate_height) - math.max(source_y, candidate_y)
  if overlap <= layout_epsilon then
    return nil
  end
  if direction == "left" then
    local distance = source_x - (candidate_x + candidate_width)
    if distance >= -layout_epsilon then
      return math.max(0, distance), overlap
    end
  else
    local distance = candidate_x - (source_x + source_width)
    if distance >= -layout_epsilon then
      return math.max(0, distance), overlap
    end
  end
  return nil
end

local function adjacent_tiled_pane(view, focused_block_id, direction)
  local window = active_window(view)
  if not window then
    return nil
  end

  local blocks = {}
  for _, layer in ipairs(window.layers or {}) do
    if layer.kind == "tiled" and layer.layout then
      collect_layout_blocks(layer.layout, blocks)
    end
  end

  local focused_block
  for _, block in ipairs(blocks) do
    if block.block_id == focused_block_id then
      focused_block = block
      break
    end
  end
  if not focused_block then
    return nil
  end

  local nearest_block_id
  local nearest_distance
  local nearest_overlap
  for _, candidate in ipairs(blocks) do
    if candidate.block_id ~= focused_block_id then
      local distance, overlap = adjacent_pane_distance(focused_block, candidate, direction)
      if
        distance
        and overlap
        and (
          not nearest_distance
          or distance < nearest_distance - layout_epsilon
          or (math.abs(distance - nearest_distance) <= layout_epsilon and overlap > nearest_overlap)
        )
      then
        nearest_block_id = candidate.block_id
        nearest_distance = distance
        nearest_overlap = overlap
      end
    end
  end
  return nearest_block_id
end

local function focus_adjacent_pane(session_id, block_id, direction)
  local view, view_error = rex.session.view({ session_id = session_id })
  if not view then
    rex.log("warn", "pane navigation: view lookup failed: " .. tostring(view_error))
    return nil, view_error
  end

  local target_block_id = adjacent_tiled_pane(view, block_id, direction)
  if target_block_id then
    return rex.session.focus_block({ session_id = session_id, block_id = target_block_id })
  end
  return rex.call("session.focus_direction", {
    session_id = session_id,
    direction = direction,
    wrap = false,
  })
end

local function bind_pane_navigation(key, direction)
  rex.bind(key, function(ctx)
    if not ctx.session_id or not ctx.block_id then
      return false
    end

    local process, process_error = rex.call("block.method", {
      session_id = ctx.session_id,
      block_id = ctx.block_id,
      method = "process",
    })
    if process and is_nvim_foreground(process.foreground) then
      return false
    end
    if not process and process_error then
      rex.log("warn", "pane navigation: process lookup failed: " .. tostring(process_error))
    end

    local title = rex.call("block.method", {
      session_id = ctx.session_id,
      block_id = ctx.block_id,
      method = "title",
    })
    if title and type(title.title) == "string" and title.title:lower() == "nvim" then
      return false
    end

    local result, focus_error = focus_adjacent_pane(ctx.session_id, ctx.block_id, direction)
    if not result then
      rex.log("warn", "pane navigation: focus failed: " .. tostring(focus_error))
    end
    return true
  end)
end

bind_pane_navigation("ctrl+h", "left")
bind_pane_navigation("ctrl+j", "down")
bind_pane_navigation("ctrl+k", "up")
bind_pane_navigation("ctrl+l", "right")
