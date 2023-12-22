local wezterm = require("wezterm")
local mux = wezterm.mux
-- local act = wezterm.action

wezterm.on("gui-startup", function(cmd)
  -- -- allow `wezterm start -- something` to affect what we spawn
  -- -- in our initial window
  -- local args = {}
  -- if cmd then
  --   args = cmd.args
  -- end

  local function custom_coding_workspace(cwd, name)
    -- local directory = wezterm.home_dir .. cwd
    local directory = cwd
    local workspace_name = name
    local nvim_tab, nvim_pane, window = mux.spawn_window({
      workspace = workspace_name,
      cwd = directory,
    })
    -- nvim_pane:send_text("nvim\n")
    local pnpm_tab, git_pane, _ = window:spawn_tab({
      cwd = directory,
    })
    local pnpm_pane = git_pane:split({
      direction = "Right",
      size = 0.5,
      cwd = directory,
    })
    nvim_tab:activate()
  end

  custom_coding_workspace("/Users/jbef/Developer/dotfiles", "dotfiles")
  custom_coding_workspace("/Users/jbef/Developer/starter-template-peninsula", "starter-template-peninsula")
  custom_coding_workspace("/Users/jbef/Developer/peninsula.studio", "peninsula.studio")
  custom_coding_workspace("/Users/jbef/Developer/Clients/guidoaudisio.com", "guidoaudisio.com")
  custom_coding_workspace("/Users/jbef/Developer/Clients/cnglawyers.com", "cng-lawyers")
  custom_coding_workspace("/Users/jbef/Developer/InvitaBoda/dani-&-mayte", "dani-&-mayte")
  custom_coding_workspace("/Users/jbef/Developer/InvitaBoda/esther-&-javi", "esther-&-javi")
  custom_coding_workspace("/Users/jbef/Developer/InvitaBoda/ivan-y-ana", "ivan-Y-ana")
  custom_coding_workspace("/Users/jbef/Developer/Clients/europrestige-sample", "europrestige-sample")
  -- We want to startup in the coding workspace
  mux.set_active_workspace("dotfiles")
end)
