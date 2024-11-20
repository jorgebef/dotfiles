local M = {}

M.palette = {
  normal = {
    black = "#191D24",
    red = "#BF616A",
    green = "#A3BE8C",
    yellow = "#EBCB8B",
    blue = "#81A1C1",
    magenta = "#B48EAD",
    cyan = "#8FBCBB",
    white = "#D8DEE9",
  },
  bright = {
    black = " #3B4252",
    red = " #D06F79",
    green = "#B1D196",
    yellow = "#F0D399",
    blue = "#88C0D0",
    magenta = "#C895BF",
    cyan = "#93CCDC",
    white = "#E5E9F0",
  },
  bg = "#222630",
  fg = "#D8DEE9",
}

M.colors = {
  -- The default text color
  foreground = M.palette.white,
  -- The default background color
  background = M.palette.bg,

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "#D8DEE9",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "#2E3440",
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = "#D8DEE9",

  -- the foreground color of selected text
  selection_fg = "#D8DEE9",
  -- the background color of selected text
  selection_bg = "#2E3440",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "#191D24",

  -- The color of the split lines between panes
  split = M.palette.bright.black,

  ansi = {
    M.palette.normal.black,
    M.palette.normal.red,
    M.palette.normal.green,
    M.palette.normal.yellow,
    M.palette.normal.blue,
    M.palette.normal.magenta,
    M.palette.normal.cyan,
    M.palette.normal.white,
  },
  brights = {
    M.palette.bright.black,
    M.palette.bright.red,
    M.palette.bright.green,
    M.palette.bright.yellow,
    M.palette.bright.blue,
    M.palette.bright.magenta,
    M.palette.bright.cyan,
    M.palette.bright.white,
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = "#af8700" },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = "#D08770",

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = "#000000" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { Color = M.palette.normal.black },
  copy_mode_inactive_highlight_bg = { Color = "#B1D196" },
  copy_mode_inactive_highlight_fg = { Color = M.palette.normal.white },

  -- quick_select_label_bg = { Color = "peru" },
  -- quick_select_label_fg = { Color = "#ffffff" },
  -- quick_select_match_bg = { AnsiColor = "Navy" },
  -- quick_select_match_fg = { Color = "#ffffff" },

  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = M.palette.bg,

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = M.palette.normal.blue,
      -- The color of the text for the tab
      fg_color = M.palette.bg,

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Bold",

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = "None",

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = M.palette.normal.black,
      fg_color = "#4C566A",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = M.palette.bright.black,
      fg_color = M.palette.normal.blue,
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = M.palette.bg,
      fg_color = M.palette.normal.black,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = M.palette.bright.black,
      fg_color = M.palette.normal.white,
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

return M
