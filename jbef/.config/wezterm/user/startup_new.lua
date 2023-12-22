local wezterm = require("wezterm")
local mux = wezterm.mux
local JSON = require("user.JSON")

-- function DeepPrint(e)
--   -- if e is a table, we should iterate over its elements
--   if type(e) == "table" then
--     for k, v in pairs(e) do -- for every element in the table
--       wezterm.log_info(k)
--       DeepPrint(v) -- recursively repeat the same procedure
--     end
--   else -- if not, we can just print it
--     wezterm.log_info(e)
--   end
-- end

-- DeepPrint(myTable)

local pc_name = "file://jorges-mbp"
local substring_index = pc_name:len() + 1

local function setContains(set, val)
  -- return set[key] ~= nil
  local contains = false
  for _, v in pairs(set) do
    if v == val then
      contains = true
    end
  end
  return contains
end

wezterm.on("gui-startup", function(cmd)
  local file = io.open("/Users/jbef/.config/wezterm/session.json", "r")

  -- ==========================
  -- check if file exists
  if file == nil then
    return
  end
  --==========================

  local dump = file:read("*a")
  file:close()
  local decoded_dump = JSON:decode(dump)

  local created_sessions = {}

  local function custom_startup()
    -- iterate through dumped session info in decoded JSON
    for _, v in pairs(decoded_dump) do
      local workspace = v["workspace"]
      wezterm.log_info(workspace)

      -- Iterate over the sessions array to check if already exists
      -- Check if session already exists, if so, create new tab
      if setContains(created_sessions, workspace) then
        wezterm.log_info(workspace .. " ALREADY EXISTS")
      else
        table.insert(created_sessions, workspace)
        wezterm.log_info(created_sessions)
        local good_cwd = v["cwd"]:sub(substring_index)
        wezterm.log_info(good_cwd)
        local tab, pane, window = mux.spawn_window({
          workspace = workspace,
          cwd = good_cwd,
        })
      end
    end
  end

  custom_startup()
end)
