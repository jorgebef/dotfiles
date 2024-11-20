local M = {}

M.palette = {
  dragonBlack0 = "#0D0C0C",
  dragonRed = "#C4746E",
  dragonGreen2 = "#8A9A7B",
  dragonYellow = "#C4B28A",
  dragonBlue2 = "#8BA4B0",
  dragonPink = "#A292A3",
  dragonAqua = "#8EA4A2",
  dragonWhite = "#c5c9c5",

    --   -- Bg Shades
    -- sumiInk0 = "#16161D",
    -- sumiInk1 = "#181820",
    -- sumiInk2 = "#1a1a22",
    -- sumiInk3 = "#1F1F28",
    -- sumiInk4 = "#2A2A37",
    -- sumiInk5 = "#363646",
    -- sumiInk6 = "#54546D", --fg

  dragonGray = "#A6A69C",
  waveRed = "#E46876",
  dragonGreen = "#87A987",
  carpYellow = "#E6C384",
  springBlue = "#7FB4CA",
  springViolet1 = "#938AA9",
  waveAqua2 = "#7AA89F",

  waveBlue2 = "#2D4F67",
  oldWhite = "#C8C093",
  dragonBlack3 = "#181616",
  sumiInk0 = "#16161D",
  dragonBlack6 = "#625e5a",
  dragonViolet = "#8992a7",
  dragonOrange2 = "#b98d7b",
}

M.colors = {
  foreground = M.palette.dragonWhite,
  background = M.palette.dragonBlack3,

  ansi = {
    M.palette.dragonBlack0,
    M.palette.dragonRed,
    M.palette.dragonGreen2,
    M.palette.dragonYellow,
    M.palette.dragonBlue2,
    M.palette.dragonPink,
    M.palette.dragonAqua,
    M.palette.dragonWhite,
  },
  brights = {
    M.palette.dragonGray,
    M.palette.waveRed,
    M.palette.dragonGreen,
    M.palette.carpYellow,
    M.palette.springBlue,
    M.palette.springViolet1,
    M.palette.waveAqua2,
    M.palette.dragonWhite,
  },

  cursor_bg = M.palette.oldWhite,
  cursor_fg = M.palette.dragonBlack0,
  cursor_border = M.palette.oldWhite,

  selection_fg = M.palette.oldWhite,
  selection_bg = M.palette.waveBlue2,

  scrollbar_thumb = M.palette.sumiInk0,
  split = M.palette.sumiInk0,

  copy_mode_active_highlight_fg = { Color = M.palette.dragonBlack0 },
  copy_mode_inactive_highlight_bg = { Color = M.palette.dragonGreen2 },
  copy_mode_inactive_highlight_fg = { Color = M.palette.dragonWhite },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = M.palette.dragonOrange2,

  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = M.palette.dragonBlack0,

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = M.palette.dragonViolet,
      -- The color of the text for the tab
      fg_color = M.palette.dragonBlack0,

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
      bg_color = M.palette.dragonBlack0,
      fg_color = M.palette.dragonBlack6,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = M.palette.dragonGray,
      fg_color = M.palette.dragonBlue2,
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = M.palette.dragonBlack3,
      fg_color = M.palette.dragonBlack6,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = M.palette.dragonGray,
      fg_color = M.palette.dragonWhite,
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

return M
