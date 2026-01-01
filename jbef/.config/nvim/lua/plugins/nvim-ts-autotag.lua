-- Autoclosing tags for HTML and JSX.
return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
        skip_tags = {
          "area",
          "base",
          "br",
          "col",
          "command",
          "embed",
          "hr",
          "img",
          "slot",
          "input",
          "keygen",
          "link",
          "meta",
          "param",
          "source",
          "track",
          "wbr",
          "menuitem",
          "Image",
        },
      },
    },
    -- config = function(_, opts)
    --   require("nvim-ts-autotag").setup(opts)
    -- end,
  },
}
