vim.o.guifont = "Hack Nerd Font:h12"

vim.opt.showmode = false
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  event = "VeryLazy",
  config = function()
    local colors = {
      bg       = "#1e1e2e",
      fg       = "#cdd6f4",
      cyan     = "#89dceb",
      green    = "#a6e3a1",
      orange   = "#fab387",
      magenta  = "#cba6f7",
      red      = "#f38ba8",
      pink     = "#f5c2e7",
      yellow   = "#f9e2af",
    }

    local mode_color = {
      n = colors.green,
      i = colors.pink,
      v = colors.magenta,
      V = colors.magenta,
      [""] = colors.magenta,
      c = colors.orange,
      R = colors.red,
      t = colors.cyan,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
    }

    -- main config table defined first
    local config = {
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {},
    }

    -- now helpers can safely use `config`
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- MODE
    ins_left({
      function()
        local mode = vim.fn.mode()
        local map = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          [""] = "V-BLOCK",
          c = "COMMAND",
          R = "REPLACE",
          t = "TERMINAL",
        }
        return " " .. (map[mode] or mode) .. " "
      end,
      color = function()
        local mode = vim.fn.mode()
        return { fg = colors.bg, bg = mode_color[mode] or colors.pink, gui = "bold" }
      end,
      padding = { left = 1, right = 1 },
    })

    -- FILENAME
    ins_left({
      "filename",
      path = 1, -- relative path
      color = { fg = colors.cyan, gui = "bold" },
      cond = conditions.buffer_not_empty,
    })

    -- BRANCH
    ins_left({
      "branch",
      icon = "",
      color = { fg = colors.magenta, gui = "bold" },
    })

    -- GIT DIFF
    ins_left({
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    -- DIAGNOSTICS
    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    -- RIGHT ALIGN SEPARATOR
    ins_left({ function() return "%=" end })

    require("lualine").setup(config)
  end,
}
