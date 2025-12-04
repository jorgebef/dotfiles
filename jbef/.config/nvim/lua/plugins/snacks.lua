return {
  "folke/snacks.nvim",
  dependencies = { "folke/todo-comments.nvim" },
  priority = 1000,
  lazy = false,

  opts = function()
    ---@type snacks.Config
    local opts = {
      dashboard = { enabled = true },
      image = { enabled = true },
      notifier = {
        enabled = true,
        filter = function(notif)
          -- This filters out the lsp notifications for "No information available"
          -- that usually happen when more than 1 lsp server is attached to a single file
          if notif.msg == "No information available" then
            return false
          else
            return true
          end
        end,
      },
      notify = { enabled = true },
      rename = { enabled = true },
      input = {
        enabled = true,
        prompt_pos = "left",
      },
      explorer = { enabled = true },
      terminal = { enabled = true },
      picker = {
        sources = {
          grep = {},
          files = {
            hidden = true,
            ignored = false,
            formatters = {
              file = {
                truncate = 40,
                filename_only = false,
              },
            },
            -- live = true,
            -- limit = 60,
          },
        },
        layout = {
          reverse = true,
          layout = {
            box = "horizontal",
            -- backdrop = false,
            width = 0.7,
            height = 0.85,
            border = "none",
            {
              box = "vertical",
              {
                win = "list",
                -- title = " Results ",
                title_pos = "center",
                -- border = require("config.ui").border.BlockThick,
                border = { " " },
              },
              {
                win = "input",
                height = 1,
                -- border = require("config.ui").border.BlockThick,
                border = { " " },
                -- title = "{title} {live} {flags}",
                -- title = "{title}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview}",
              width = 0.5,
              -- border = require("config.ui").border.BlockThick,
              border = { "▌", " ", " ", " ", " ", " ", "▌", "▌" },
              title_pos = "center",
            },
          },
        },
        -- finder = "files",
        -- format = "file",
        show_empty = false,
        hidden = false,
        ignored = false,
        follow = false,
        supports_live = true,
        win = {
          input = {
            keys = {
              ["<C-h>"] = { "toggle_ignored", mode = { "i", "n" } },
              -- FIX: This fixes an issue that by quickly doube pressing Esc to exit,
              -- it returns to a different buffer than the one that was last active
              ["<Esc>"] = { "close", mode = { "n" } },
            },
          },
        },
        ---@class snacks.picker.matcher.Config
        matcher = {
          fuzzy = true, -- use fuzzy matching
          smartcase = true, -- use smartcase
          ignorecase = true, -- use ignorecase
          sort_empty = false, -- sort results when the search string is empty
          filename_bonus = false, -- give bonus for matching file names (last part of the path)
          file_pos = true, -- support patterns like `file:line:col` and `file:line`
          -- the bonusses below, possibly require string concatenation and path normalization,
          -- so this can have a performance impact for large lists and increase memory usage
          cwd_bonus = false, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = false, -- give more weight to chronological order
        },
        sort = {
          -- default sort is by score, text length and index
          fields = { "score:desc", "#text", "idx" },
        },
        ---@class snacks.picker.debug
        debug = {
          scores = false, -- show scores in the list
          leaks = false, -- show when pickers don't get garbage collected
          explorer = false, -- show explorer debug info
          files = false, -- show file debug info
          grep = false, -- show file debug info
          proc = false, -- show proc debug info
          extmarks = false, -- show extmarks errors
        },
      },

      styles = {
        input = {
          relative = "editor",
          position = "float",
          -- row = (vim.api.nvim_win_get_height(0) / 2) - 1,
          row = 0.46,
        },
      },
    }
    return opts
  end,

  keys = {
    -- Picker keymaps======================================
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          cmd = "fd",
          args = {
            "--color=never",
            "--exclude",
            ".git",
            -- "--exclude",
            -- "node_modules",
            "--exclude",
            ".next",
          },
          finder = "files",
          format = "file",
          show_empty = true,
          hidden = true,
          ignored = false,
          follow = true,
          supports_live = true,
        })
      end,
      desc = "Find Files",
      nowait = true,
    },

    {
      "<leader>fg",
      function()
        Snacks.picker.grep({
          cmd = "rg",
          args = {
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--glob",
            "!.git/",
            "--glob",
            "!package-lock.json",
            "--glob",
            "!pnpm-lock.yaml",
          },
        })
      end,
      desc = "Grep live",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    -- {
    --   "<leader>e",
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = "File Explorer",
    -- },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    -- {
    --   "<leader>fc",
    --   function()
    --     Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    --   end,
    --   desc = "Find Config File",
    -- },
    -- {
    --   "<leader>fg",
    --   function()
    --     Snacks.picker.git_files()
    --   end,
    --   desc = "Find Git Files",
    -- },
    -- {
    --   "<leader>fp",
    --   function()
    --     Snacks.picker.projects()
    --   end,
    --   desc = "Projects",
    -- },
    -- {
    --   "<leader>fr",
    --   function()
    --     Snacks.picker.recent()
    --   end,
    --   desc = "Recent",
    -- },
    -- git
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git Log File",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    -- {
    --   "<leader>sg",
    --   function()
    --     Snacks.lazygit()
    --   end,
    --   desc = "Grep",
    -- },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    -- {
    --   "<leader>sc",
    --   function()
    --     Snacks.picker.command_history()
    --   end,
    --   desc = "Command History",
    -- },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    -- {
    --   "<leader>sh",
    --   function()
    --     Snacks.picker.help()
    --   end,
    --   desc = "Help Pages",
    -- },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },

    {
      "<leader>si",
      function()
        Snacks.picker.icons({
          layout = {
            preset = "default",
            backdrop = 60,
          },
        })
      end,
      desc = "Icons",
    },

    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },

    {
      "<leader>sK",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },

    -- {
    --   "<leader>sl",
    --   function()
    --     Snacks.picker.loclist()
    --   end,
    --   desc = "Location List",
    -- },

    {
      "<leader>sM",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },

    -- {
    --   "<leader>sM",
    --   function()
    --     Snacks.picker.man()
    --   end,
    --   desc = "Man Pages",
    -- },

    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },

    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },

    {
      "<leader>sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },

    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },

    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes({
          finder = "vim_colorschemes",
          format = "text",
          preview = "colorscheme",
          preset = "vertical",
          confirm = function(picker, item)
            picker:close()
            if item then
              picker.preview.state.colorscheme = nil
              vim.schedule(function()
                vim.cmd("colorscheme " .. item.text)
              end)
            end
          end,
        })
      end,
      desc = "Colorschemes",
    },

    -- =================================================
    -- LSP ============================================
    -- =================================================
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions({
          finder = "lsp_definitions",
          format = "file",
          include_current = true,
          auto_confirm = true,
          jump = { tagstack = true, reuse_win = true },
        })
      end,
      desc = "Goto Definition",
    },

    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },

    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },

    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },

    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },

    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },

    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },

    -- {
    --   "<C-t>",
    --   function()
    --     Snacks.terminal.toggle("fish", { win = { max_width = 210, max_height = 180 } })
    --   end,
    --   mode = { "n", "t" },
    --   desc = "Toggle terminal",
    -- },

    -- TODO comments
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
