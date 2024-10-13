-- This is how you load the package for other lua configs
-- =====================================================================
-- package.path = package.path .. ";/Users/jbef/.config/colors/[package_name].lua"
-- local kanagawa_custom = require("kanagawa-custom")
-- =====================================================================
---@alias ColorSpec string RGB Hex string
---@alias ColorTable table<string, ColorSpec>
-- =====================================================================

---@class KanagawaCustom Colors for my custom kanagawa palette
local M = {}

---@class KanagawaCustomPalette
M.palette = {
  -- Bg Shades
  sumiInk0 = "#16161D",
  sumiInk1 = "#181820",
  sumiInk2 = "#1a1a22",
  sumiInk3 = "#1F1F28",
  sumiInk4 = "#21212F",
  sumiInk5 = "#303040",
  sumiInk6 = "#434351", --fg

  -- Popup and Floats
  waveBlue1 = "#223249",
  waveBlue2 = "#2D4F67",

  -- Diff and Git
  winterGreen = "#2B3328",
  winterYellow = "#49443C",
  winterRed = "#43242B",
  winterBlue = "#252535",
  autumnGreen = "#76946A",
  autumnRed = "#C34043",
  autumnYellow = "#DCA561",

  -- Diag
  samuraiRed = "#E82424", --unused
  roninYellow = "#FF9E3B", --unused
  waveAqua1 = "#6A9589",
  dragonBlue = "#658594", --unused

  -- Fg and Comments
  -- oldWhite = "#C8C093",
  oldWhite = "#AFACA9",
  fujiWhite = "#CFCECE",
  fujiGray = "#727169",

  oniViolet = "#957FB8",
  oniViolet2 = "#b8b4d0",
  crystalBlue = "#7E9CD8",
  springViolet1 = "#938AA9",
  springViolet2 = "#9CABCA",
  springBlue = "#7FB4CA",
  lightBlue = "#A3D4D5", -- unused yet
  waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua

  -- waveAqua2  = "#68AD99",
  -- waveAqua4  = "#7AA880",
  -- waveAqua5  = "#6CAF95",
  -- waveAqua3  = "#68AD99",

  springGreen = "#98BB6C",
  boatYellow1 = "#938056", --unused
  boatYellow2 = "#C0A36E",
  carpYellow = "#E6C384",

  sakuraPink = "#D27E99",
  waveRed = "#E46876",
  peachRed = "#FF5D62",
  surimiOrange = "#FFA066",
  katanaGray = "#717C7C",

  dragonBlack0 = "#0d0c0c", --unused
  dragonBlack1 = "#12120f", --unused
  dragonBlack2 = "#1D1C19", --unused
  dragonBlack3 = "#181616", --unused
  dragonBlack4 = "#282727", --unused
  dragonBlack5 = "#393836", --unused
  dragonBlack6 = "#625e5a", --unused

  dragonWhite = "#c5c9c5",
  dragonGreen = "#87a987",
  dragonGreen2 = "#8a9a7b",
  dragonPink = "#a292a3",
  dragonOrange = "#b6927b",
  dragonOrange2 = "#b98d7b",
  dragonGray = "#a6a69c",
  dragonGray2 = "#9e9b93",
  dragonGray3 = "#7a8382",
  dragonBlue2 = "#8ba4b0",
  dragonViolet = "#8992a7",
  dragonRed = "#c4746e",
  dragonAqua = "#8ea4a2",
  dragonAsh = "#737c73",
  dragonTeal = "#949fb5",
  dragonYellow = "#c4b28a", --"#a99c8b",
  -- "#8a9aa3",

  lotusInk1 = "#545464",
  lotusInk2 = "#43436c",
  lotusGray = "#dcd7ba",
  lotusGray2 = "#716e61",
  lotusGray3 = "#8a8980",
  lotusWhite0 = "#d5cea3",
  lotusWhite1 = "#dcd5ac",
  lotusWhite2 = "#e5ddb0",
  lotusWhite3 = "#f2ecbc",
  lotusWhite4 = "#e7dba0",
  lotusWhite5 = "#e4d794",
  lotusViolet1 = "#a09cac",
  lotusViolet2 = "#766b90",
  lotusViolet3 = "#c9cbd1",
  lotusViolet4 = "#624c83",
  lotusBlue1 = "#c7d7e0",
  lotusBlue2 = "#b5cbd2",
  lotusBlue3 = "#9fb5c9",
  lotusBlue4 = "#4d699b",
  lotusBlue5 = "#5d57a3",
  lotusGreen = "#6f894e",
  lotusGreen2 = "#6e915f",
  lotusGreen3 = "#b7d0ae",
  lotusPink = "#b35b79",
  lotusOrange = "#cc6d00",
  lotusOrange2 = "#e98a00",
  lotusYellow = "#77713f",
  lotusYellow2 = "#836f4a",
  lotusYellow3 = "#de9800",
  lotusYellow4 = "#f9d791",
  lotusRed = "#c84053",
  lotusRed2 = "#d7474b",
  lotusRed3 = "#e82424",
  lotusRed4 = "#d9a594",
  lotusAqua = "#597b75",
  lotusAqua2 = "#5e857a",
  lotusTeal1 = "#4e8ca2",
  lotusTeal2 = "#6693bf",
  lotusTeal3 = "#5a7785",
  lotusCyan = "#d7e3d8",
}

---@class KanagawaCustomTheme
---@field syn SyntaxElements
---@field diag DiagnosticsElements
---@field vcs VCSElements
---@field diff DiffElements
---@field ui UiElements
---@field term ColorSpec[]

---@class SyntaxElements
---@field string ColorSpec
---@field variable ColorSpec
---@field number ColorSpec
---@field constant ColorSpec
---@field identifier ColorSpec
---@field parameter ColorSpec
---@field fun ColorSpec
---@field statement ColorSpec
---@field keyword ColorSpec
---@field operator ColorSpec
---@field preproc ColorSpec
---@field type ColorSpec
---@field regex ColorSpec
---@field deprecated ColorSpec
---@field comment ColorSpec
---@field punct ColorSpec
---@field special1 ColorSpec
---@field special2 ColorSpec
---@field special3 ColorSpec

---@class DiagnosticsElements
---@field error ColorSpec
---@field ok ColorSpec
---@field warning ColorSpec
---@field info ColorSpec
---@field hint ColorSpec

---@class VCSElements
---@field added ColorSpec
---@field removed ColorSpec
---@field changed ColorSpec

---@class DiffElements
---@field add ColorSpec
---@field delete ColorSpec
---@field change ColorSpec
---@field text ColorSpec

---@class UiElements
---@field fg ColorSpec Default foreground
---@field fg_dim ColorSpec Dimmed foreground
---@field fg_reverse ColorSpec
---@field bg_dim ColorSpec Dimmed background
---@field bg_m3 ColorSpec
---@field bg_m2 ColorSpec
---@field bg_m1 ColorSpec
---@field bg ColorSpec Default background
---@field bg_p1 ColorSpec Lighter background ColorColumn, Folded, Gutter
---@field bg_p2 ColorSpec Lighter background Cursor{Line,Column}, TabLineSel (Selected Items)
---@field bg_gutter ColorSpec {Sign,Fold}Column, LineNr
---@field special ColorSpec SpecialKey
---@field nontext ColorSpec LineNr, NonText
---@field whitespace ColorSpec Whitespace
---@field bg_search ColorSpec
---@field bg_visual ColorSpec
---@field pmenu MenuElements
---@field float FloatElements

---@class FloatElements
---@field fg ColorSpec
---@field bg ColorSpec
---@field fg_border ColorSpec
---@field bg_border ColorSpec

---@class MenuElements
---@field bg ColorSpec
---@field fg ColorSpec
---@field fg_sel ColorSpec
---@field bg_sel ColorSpec
---@field bg_sbar ColorSpec
---@field bg_thumb ColorSpec

---@type KanagawaCustomTheme
M.wave = {
  ui = {
    fg = M.palette.fujiWhite,
    fg_dim = M.palette.oldWhite,
    fg_reverse = M.palette.waveBlue1,

    bg_dim = M.palette.sumiInk1,
    bg_gutter = "none",

    bg_m3 = M.palette.sumiInk0,
    bg_m2 = M.palette.sumiInk1,
    bg_m1 = M.palette.sumiInk2,
    bg = M.palette.sumiInk3,
    bg_p1 = M.palette.sumiInk4,
    bg_p2 = M.palette.sumiInk5,

    special = M.palette.springViolet1,
    nontext = M.palette.sumiInk6,
    whitespace = M.palette.sumiInk6,

    bg_search = M.palette.waveBlue2,
    bg_visual = M.palette.sumiInk6,

    pmenu = {
      -- fg = M.palette.fujiWhite,
      fg = M.palette.oldWhite,
      fg_sel = "none", -- This is important to make highlights pass-through
      -- bg = M.palette.waveBlue1,
      bg = "none",
      -- bg_sel = M.palette.waveBlue2,
      bg_sel = M.palette.sumiInk5,
      -- bg_sbar = M.palette.waveBlue1,
      bg_sbar = M.palette.sumiInk2,
      -- bg_thumb = M.palette.waveBlue2,
      bg_thumb = M.palette.sumiInk5,
    },
    float = {
      fg = M.palette.oldWhite,
      -- bg = M.palette.sumiInk0,
      bg = "none",
      fg_border = M.palette.sumiInk6,
      -- bg_border = M.palette.sumiInk0,
      bg_border = "none",
    },
  },
  syn = {
    string = M.palette.springGreen,
    variable = "none",
    number = M.palette.sakuraPink,
    constant = M.palette.surimiOrange,
    identifier = M.palette.carpYellow,
    -- parameter  = "#C3B1B1",
    -- parameter  = "#B1ADC8",
    -- parameter  = "#b8b4d0",
    parameter = M.palette.oniViolet2,
    -- parameter = "#d5a4a6",
    -- parameter  = "#C8ADAD",
    -- parameter  = "#d7a8a8",
    fun = M.palette.crystalBlue,
    statement = M.palette.oniViolet,
    keyword = M.palette.oniViolet,
    operator = M.palette.boatYellow2,
    preproc = M.palette.waveRed, --lightBlue? deserves its own color
    type = M.palette.waveAqua2,
    regex = M.palette.boatYellow2,
    deprecated = M.palette.katanaGray,
    comment = M.palette.fujiGray,
    punct = M.palette.springViolet2,
    special1 = M.palette.springBlue,
    special2 = M.palette.waveRed,
    special3 = M.palette.peachRed,
  },
  vcs = {
    added = M.palette.autumnGreen,
    removed = M.palette.autumnRed,
    changed = M.palette.autumnYellow,
  },
  diff = {
    add = M.palette.winterGreen,
    delete = M.palette.winterRed,
    change = M.palette.winterBlue,
    text = M.palette.winterYellow,
  },
  diag = {
    ok = M.palette.springGreen,
    error = M.palette.autumnRed,
    warning = M.palette.autumnYellow,
    info = M.palette.springBlue,
    hint = M.palette.waveAqua1,
  },
  term = {
    M.palette.sumiInk0, -- black
    M.palette.autumnRed, -- red
    M.palette.autumnGreen, -- green
    M.palette.boatYellow2, -- yellow
    M.palette.crystalBlue, -- blue
    M.palette.oniViolet, -- magenta
    M.palette.waveAqua1, -- cyan
    M.palette.oldWhite, -- white
    M.palette.fujiGray, -- bright black
    M.palette.autumnRed, -- bright red
    M.palette.springGreen, -- bright green
    M.palette.carpYellow, -- bright yellow
    M.palette.springBlue, -- bright blue
    M.palette.springViolet1, -- bright magenta
    M.palette.waveAqua2, -- bright cyan
    M.palette.fujiWhite, -- bright white
    M.palette.surimiOrange, -- extended color 1
    M.palette.peachRed, -- extended color 2
  },
}

return M
