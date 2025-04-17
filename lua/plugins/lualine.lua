vim.opt.showmode = false
vim.o.guifont = "Hack Nerd Font:h12"

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "SmiteshP/nvim-navic",
  },
  event = "VeryLazy",
  config = function()
    local navic = require("nvim-navic")

    local colors = {
      bg      = "#1e1e2e",
      fg      = "#cdd6f4",
      cyan    = "#89dceb",
      green   = "#a6e3a1",
      orange  = "#fab387",
      magenta = "#cba6f7",
      red     = "#f38ba8",
      pink    = "#f5c2e7",
      yellow  = "#f9e2af",
    }

    local mode_color = {
      n = colors.green,
      i = colors.pink,
      v = colors.magenta,
      V = colors.magenta,
      ["\22"] = colors.magenta,
      c = colors.orange,
      R = colors.red,
      t = colors.cyan,
    }

    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            function()
              local mode_map = {
                n = "NORMAL",
                i = "INSERT",
                v = "VISUAL",
                V = "V-LINE",
                ["\22"] = "V-BLOCK",
                c = "COMMAND",
                R = "REPLACE",
                t = "TERMINAL",
              }
              local mode = vim.fn.mode()
              return " " .. (mode_map[mode] or mode) .. " "
            end,
            color = function()
              local mode = vim.fn.mode()
              return {
                fg = colors.bg,
                bg = mode_color[mode] or colors.pink,
                gui = "bold",
              }
            end,
            padding = { left = 4, right = 4 },
          },
        },
        lualine_b = {},

        lualine_c = {
          {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            icon = "",
            color = { fg = colors.cyan, gui = "bold" },
          },
          {
            function()
              return vim.fn.expand("%:t")
            end,
            icon = "",
            color = { fg = colors.magenta, gui = "bold" },
            cond = function()
              return vim.fn.empty(vim.fn.expand("%:t")) == 0
            end,
          },
          {
            "branch",
            icon = "",
            color = { fg = colors.magenta, gui = "bold" },
          },
          {
            function()
              return navic.is_available() and navic.get_location() or ""
            end,
            color = { fg = colors.yellow },
            cond = function()
              return package.loaded["nvim-navic"] and navic.is_available()
            end,
          },
        },

        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn  = { fg = colors.yellow },
              info  = { fg = colors.cyan },
            },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added    = { fg = colors.green },
              modified = { fg = colors.orange },
              removed  = { fg = colors.red },
            },
            cond = function()
              return vim.fn.winwidth(0) > 80
            end,
          },
        },

        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = {},
    })
  end,
}
