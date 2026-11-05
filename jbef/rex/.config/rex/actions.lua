local util = require("util")

rex.action({
  name = "floating_pane_with_command",
  title = "Launch in Floating Pane",
  run = function(ctx, args)
    util.create_floating_pane(ctx, args)
    return true
  end,
})

rex.action({
  name = "split_pane_with_command",
  title = "Launch in Split Pane",
  run = function(ctx, args)
    util.launch_split_command(ctx, args)
    return true
  end,
})
