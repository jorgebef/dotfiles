local M = {}

-- Working directory the focused terminal last reported, as a plain path.
-- The terminal reports it as a URL like file://host/Users/me/some%20dir.
function M.current_dir(ctx)
  if not ctx.block_id then
    return nil
  end
  local ok, res = pcall(rex.block.call, "com.superlogical.terminal", "pwd", { block_id = ctx.block_id })
  local url = ok and res and res.pwd
  if not url then
    return nil
  end
  local path = url:match("^file://[^/]*(/.*)$") or url
  return (path:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end))
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
local FLOAT_SIZE = 0.6
local FLOAT_STEP = 0.02

function M.float_bounds(win)
  local origin = (1 - FLOAT_SIZE) / 2
  local taken = {}
  for _, layer in ipairs(win and win.layers or {}) do
    local b = layer.bounds
    if layer.kind == "floating" and b then
      taken[#taken + 1] = b
    end
  end
  local function is_taken(pos)
    for _, b in ipairs(taken) do
      if math.abs(b[1] - pos) < 1e-3 and math.abs(b[2] - pos) < 1e-3 then
        return true
      end
    end
    return false
  end

  local pos = origin
  local steps = math.floor((1 - FLOAT_SIZE - origin) / FLOAT_STEP + 1e-9)
  for i = 0, steps do
    pos = origin + i * FLOAT_STEP
    if not is_taken(pos) then
      break
    end
    if i == steps then
      pos = origin -- every spot is taken; start stacking from the center again
    end
  end
  return { pos, pos, FLOAT_SIZE, FLOAT_SIZE }
end

function M.create_floating_pane(args, ctx)
  local view = rex.session.view({})
  local win = view and M.target_window(view, ctx.block_id)
  local opts = { exit = { on_completion = true }, cwd = M.current_dir(ctx) }
  for k, v in pairs(args) do
    opts[k] = v
  end
  local layer, err = rex.session.new_layer({
    window_id = win and win.window_id,
    bounds = M.float_bounds(win),
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
