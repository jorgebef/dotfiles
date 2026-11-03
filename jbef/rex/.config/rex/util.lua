local M = {}

local TERMINAL = "com.superlogical.terminal"

-- The block an action was called from. ctx.block_id is left out when the
-- action isn't run from a pane (e.g. `rex do` with no -b), so fall back to the
-- focused block of the active window.
function M.focused_block(ctx)
  if ctx and ctx.block_id then
    return ctx.block_id
  end
  local view = rex.session.view({})
  for _, win in ipairs(view and view.windows or {}) do
    if win.window_id == view.active_window_id then
      return win.focused_block_id
    end
  end
end
local function call_terminal(method, block_id)
  local ok, res = pcall(rex.block.call, TERMINAL, method, { block_id = block_id })
  return ok and res or nil
end

-- Working directory of the pane an action was called from, as a plain path.
--
-- 1. The directory the shell last reported (OSC 7). It follows `cd` even while
--    something like nvim is in the foreground. It's a URL such as
--    file://host/Users/me/some%20dir.
-- 2. The real cwd of the pane's processes. A pane started straight from a
--    command (claude, lazygit, ...) has no shell to report a directory, so (1)
--    is empty there.
function M.current_dir(ctx)
  local block_id = M.focused_block(ctx)
  if not block_id then
    return nil
  end

  local res = call_terminal("pwd", block_id)
  local url = res and res.pwd
  if type(url) == "string" and url ~= "" then
    local path = url:match("^file://[^/]*(/.*)$") or url
    return (path:gsub("%%(%x%x)", function(hex)
      return string.char(tonumber(hex, 16))
    end))
  end

  local proc = call_terminal("process", block_id)
  if proc then
    local candidates = {}
    for _, p in ipairs({ proc.foreground or false, proc.child or false }) do
      if p then
        candidates[#candidates + 1] = p
      end
    end
    for _, p in ipairs(proc.ancestors or {}) do
      candidates[#candidates + 1] = p
    end
    for _, p in ipairs(candidates) do
      if type(p.cwd) == "string" and p.cwd ~= "" then
        return p.cwd
      end
    end
  end
  return nil
end

-- The window to open a floating pane in: the one holding the focused block,
-- or the active window.
function M.target_window(view, block_id)
  for _, win in ipairs(view.windows or {}) do
    for _, layer in ipairs(win.layers or {}) do
      for _, block in ipairs(layer.blocks or {}) do
        if block.block_id == block_id then
          return win
        end
      end
    end
  end
  for _, win in ipairs(view.windows or {}) do
    if win.window_id == view.active_window_id then
      return win
    end
  end
end

-- Bounds for a new centered floating pane. Each spot already taken by a
-- floating pane (minimized ones too, since they come back in place) pushes
-- the new one FLOAT_STEP further down and to the right, wrapping back to the
-- center once it would leave the window.
local FLOAT_WIDTH = 0.5
local FLOAT_HEIGHT = 0.85
local FLOAT_STEP = 0.02

function M.float_bounds(win)
  local origin_x = (1 - FLOAT_WIDTH) / 2
  local origin_y = (1 - FLOAT_HEIGHT) / 2
  local taken = {}
  for _, layer in ipairs(win and win.layers or {}) do
    local b = layer.bounds
    if layer.kind == "floating" and b then
      taken[#taken + 1] = b
    end
  end
  local function is_taken(x, y)
    for _, b in ipairs(taken) do
      if math.abs(b[1] - x) < 1e-3 and math.abs(b[2] - y) < 1e-3 then
        return true
      end
    end
    return false
  end

  -- Room left to step before the pane would leave the window, on each axis.
  -- The tighter axis decides how many spots there are.
  local steps = math.floor(math.min(origin_x, origin_y) / FLOAT_STEP + 1e-9)
  local x, y = origin_x, origin_y
  for i = 0, steps do
    x, y = origin_x + i * FLOAT_STEP, origin_y + i * FLOAT_STEP
    if not is_taken(x, y) then
      break
    end
    if i == steps then
      x, y = origin_x, origin_y -- every spot is taken; start stacking from the center again
    end
  end
  return { x, y, FLOAT_WIDTH, FLOAT_HEIGHT }
end

-- Move the border next to the focused pane one step in `direction`
-- ("left", "right", "up" or "down"), like tmux's resize-pane. It uses the
-- innermost split around the pane that runs the right way: left/right move a
-- border between side-by-side panes, up/down one between stacked panes.
-- `amount` is a fraction of the window (default 0.05).
local function find_path(node, block_id, path)
  if not node then
    return nil
  end
  if node.block_id == block_id then
    return path
  end
  if node.split then
    for _, side in ipairs({ "before", "after" }) do
      path[#path + 1] = { split = node.split, rect = node.rect, side = side }
      if find_path(node.split[side], block_id, path) then
        return path
      end
      path[#path] = nil
    end
  end
  return nil
end

local function any_block(node)
  if node.block_id then
    return node.block_id
  end
  return any_block(node.split.before)
end

function M.resize_pane(ctx, direction, amount)
  amount = amount or 0.05
  local block_id = M.focused_block(ctx)
  local view = rex.session.view({})
  local win = view and M.target_window(view, block_id)
  if not win then
    return false
  end

  local split_dir = (direction == "left" or direction == "right") and "horizontal" or "vertical"
  local sign = (direction == "right" or direction == "down") and 1 or -1

  for _, layer in ipairs(win.layers or {}) do
    local path = find_path(layer.layout, block_id, {})
    if path then
      for i = #path, 1, -1 do
        local step = path[i]
        local split = step.split
        if split.direction == split_dir then
          -- rect is { x, y, w, h } as fractions of the window
          local span = split_dir == "horizontal" and step.rect[3] or step.rect[4]
          local ratio = split.ratio + sign * amount / span
          ratio = math.max(0.05, math.min(0.95, ratio))
          rex.session.resize_pane({
            session_id = view.session_id,
            direction = split_dir,
            before_block_id = any_block(split.before),
            after_block_id = any_block(split.after),
            ratio = ratio,
          })
          return true
        end
      end
      return true -- no split that way; swallow the key anyway
    end
  end
  return false
end

function M.create_floating_pane(args, ctx)
  args = args or {}
  local view = rex.session.view({})
  local win = view and M.target_window(view, M.focused_block(ctx))
  -- An explicit `cwd` in args wins over the calling pane's directory.
  local opts = { exit = { on_completion = true }, cwd = M.current_dir(ctx) }
  for k, v in pairs(args) do
    if k ~= "bounds" then -- layer placement, not a terminal option
      opts[k] = v
    end
  end
  local layer, err = rex.session.new_layer({
    window_id = win and win.window_id,
    bounds = args.bounds or M.float_bounds(win),
    layout = {
      block = {
        flavor = "com.superlogical.terminal.shell",
        options = opts,
      },
    },
    focus = true,
  })
  if not layer then
    error("floating pane: " .. tostring(err), 0)
  end
  return true
end

function M.is_vim(ctx)
  local proc = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
  local fg = proc and proc.foreground
  if not fg then
    return false
  end
  -- `name` is not always the executable's name, so check `argv0` too
  for _, s in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
    if s:match("^n?vim") then
      return true
    end
  end
  return false
end

return M
