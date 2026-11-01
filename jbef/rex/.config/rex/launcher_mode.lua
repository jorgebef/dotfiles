local util = require("util")

rex.action({
  name = "floating_pane_with_command",
  title = "Launch in Floating Pane",
  run = function(ctx, args)
    util.create_floating_pane(args, ctx)
    return true
  end,
})
