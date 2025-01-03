-- =====================================================================
-- Here we define the symbols that should be used throughout the whole
-- neovim configuration for organisation and reusability
-- =====================================================================

---@class UISymbols
local M = {}

M.kind = {
  Text = " ",
  -- Method = "m",
  -- Function = "",
  -- Constructor = "",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  -- Variable = "",
  Variable = " ",
  Class = " ",
  Interface = " ",
  -- Module = "",
  Module = "",
  Property = "",
  Unit = " ",
  Value = " ",
  Enum = " ",
  -- Keyword = "",
  Keyword = " ",
  -- Snippet = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

M.type = {
  Array = " ",
  Number = " ",
  String = " ",
  Boolean = "蘒",
  Object = " ",
}

M.documents = {
  File = " ",
  Files = " ",
  Folder = " ",
  OpenFolder = " ",
}

M.git = {
  Branch = "",
  Add = " ",
  Mod = " ",
  Remove = " ",
  Ignore = " ",
  Rename = " ",
  Diff = " ",
  Repo = " ",
}

M.common = {
  Arrow = " ",
  Lock = " ",
  Circle = " ",
  BigCircle = " ",
  BigUnfilledCircle = " ",
  Close = " ",
  NewFile = " ",
  Search = " ",
  Lightbulb = " ",
  Project = " ",
  Dashboard = " ",
  History = " ",
  Comment = " ",
  Bug = " ",
  Code = " ",
  Telescope = " ",
  Gear = " ",
  Package = " ",
  List = " ",
  SignIn = " ",
  Check = " ",
  Fire = " ",
  Note = " ",
  BookMark = " ",
  Pencil = " ",
  -- ChevronRight = "",
  ChevronRight = " ",
  Table = " ",
  Calendar = " ",
  SeparatorSquare = "█",
  SeparatorLEndAngle = "",
  -- SeparatorLEnd = "",
  SeparatorRStartAngle = "",
  AngleLeft = "",
  AngleRight = "",
  -- SeparatorRStart = "",
  SeparatorLStart = "█",
  SeparatorREnd = "█",
  -- SeparatorLStart = "",
  -- SeparatorREnd = "",
}

M.diagnostics = {
  -- Error = " ",
  -- Warning = " ",
  -- Information = " ",
  -- Question = " ",
  -- Hint = " ",
  Error = "",
  Warning = "",
  Information = "",
  Question = "",
  Hint = "",
}

M.misc = {
  Robot = "ﮧ",
  Squirrel = "",
  Tag = "",
  Watch = "",
  Ghost1 = " ",
  Ghost2 = " ",
  Carat = " ",
}

---@class UIBorder
M.border = {
  Single = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  Square = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  Block = {
    { "▛" },
    { "▀" },
    { "▜" },
    { "▐" },
    { "▟" },
    { "▄" },
    { "▙" },
    { "▌" },
  },
  BlockThick = { "█", "▀", "█", "█", "█", "▄", "█", "█" },
  LSPBlock = {
    { "▛", "FloatBorder" },
    { "▀", "FloatBorder" },
    { "▜", "FloatBorder" },
    { "▐", "FloatBorder" },
    { "▟", "FloatBorder" },
    { "▄", "FloatBorder" },
    { "▙", "FloatBorder" },
    { "▌", "FloatBorder" },
  },
  BlockSimple = {
    { "▛" },
    { "▀" },
    { "▜" },
    { "▐" },
    { "▟" },
    { "▄" },
    { "▙" },
    { "▌" },
  },
}

return M
