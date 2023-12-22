local wezterm = require("wezterm")
local mux = wezterm.mux
local JSON = require("user.JSON")
local action_callback = wezterm.action_callback

-- local pc_name = "file://jorges-mbp"
-- local substring_index = pc_name:len() + 1

local file = io.open("/Users/jbef/.config/wezterm/session.json", "r")
local file2 = "/Users/jbef/.config/wezterm/session2.json"

local M = {}

-- -- Deep copy a table
-- local function deepcopy(tbl)
--   if type(tbl) == "table" then
--     local copy = {}
--     for k, v in pairs(tbl) do
--       copy[tostring(k)] = deepcopy(v)
--     end
--     return copy
--   end
--   return tbl
-- end

local function getTableLn(tbl)
  local getN = 0
  for _ in pairs(tbl) do
    getN = getN + 1
  end
  return getN
end

-- Save JSON data a file
local function save_json(data, json_session_file)
  local f = assert(io.open(json_session_file, "w"))
  f:write(JSON:encode(data))
  f:close()
end

function M.save_session()
  return action_callback(function()
    local sessions = {}
    for _, win in ipairs(mux.all_windows()) do
      local workspace = win:get_workspace()
      if sessions[workspace] == nil then
        sessions[workspace] = {}
      end
      wezterm.log_info(win:get_workspace())
      for _, tab in ipairs(win:tabs()) do
        local tabId = tostring(tab:tab_id())
        sessions[workspace][tabId] = {}
        for _, pane in ipairs(tab:panes_with_info()) do
          local paneId = tostring(pane.pane:pane_id())
          sessions[workspace][tabId][paneId] = {
            cwd = tostring(pane.pane:get_current_working_dir()):gsub(".*/Users", "/Users"),
            tty = tostring(pane.pane:get_foreground_process_name()),
          }
        end
      end
    end
    local dump = {
      active_workspace = mux.get_active_workspace(),
      sessions = sessions,
    }
    save_json(dump, file2)
    -- wezterm.log_info(sessions)
  end)
end

function M.restore()
  -- ==========================
  -- check if file exists
  local openFile = io.open(file2, "r")
  if openFile == nil then
    return
  end
  --==========================

  local dump = openFile:read("*a")
  openFile:close()
  ---@type table
  local decoded_dump = JSON:decode(dump)

  -- Loop through Workspaces =====================================
  for workspace, wTable in pairs(decoded_dump["sessions"]) do
    -- initialize Tab counter for each workspace ===============
    local tCount = 0
    local _, _, window = mux.spawn_window({
      workspace = workspace,
      cwd = "/Users/jbef",
    })
    -- Loop through Tabs ======================================
    for _, tTable in pairs(wTable) do
      local pCount = 0
      -- if getTableLn(wTable) > 1 and wTab:tab_id() ~= window:active_tab():tab_id() then
      if getTableLn(wTable) > 1 and tCount > 0 then
        local tab, pane, _ = window:spawn_tab({})
        tab:activate()
        pane:activate()
        tCount = tCount + 1
      else
        tCount = tCount + 1
      end

      -- initialize Pane counter for each tab ===============
      -- Loop through Panes ======================================
      for _, pTable in pairs(tTable) do
        -- -- Check if it's not the first tab ======================================
        if getTableLn(tTable) > 1 and pCount > 0 then
          window:active_pane():split({ cwd = pTable["cwd"] })
          pCount = pCount + 1
        else
          window:active_pane():send_text("cd " .. pTable["cwd"] .. "\r")
          pCount = pCount + 1
        end
      end
    end
  end

  mux.set_active_workspace(decoded_dump["active_workspace"])
end

return M
