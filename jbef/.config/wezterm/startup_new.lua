local wezterm = require("wezterm")
local dkjson = require("dkjson")
local JSON = require("JSON")

local file = io.open("/Users/jbef/.config/wezterm/session.json", "r")
local content = file:read("*a")
file:close()
local myTable = dkjson.decode(content)
local table = JSON:decode(content)

function DeepPrint(e)
  -- if e is a table, we should iterate over its elements
  if type(e) == "table" then
    for k, v in pairs(e) do -- for every element in the table
      wezterm.log_info(k)
      DeepPrint(v) -- recursively repeat the same procedure
    end
  else -- if not, we can just print it
    wezterm.log_info(e)
  end
end

DeepPrint(myTable)

-- for k, v in pairs(table) do
--   wezterm.log_info(k, v)
-- end
-- -- wezterm.log_info(myTable)
