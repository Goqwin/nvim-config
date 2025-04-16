vim.opt.showmode = false
vim.o.guifont = "Hack Nerd Font:h12"

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "SmiteshP/nvim-navic",  -- Navic for breadcrumb navigation
  },
  event = "VeryLazy",
  config = function()

    local navic = require("nvim-navic")

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
      ["\22"] = colors.magenta,  -- Visual block (CTRL+V)
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
        lualine_c = {},  -- Put folder path here
        lualine_x = {},  -- Right section, for diagnostics and diff
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
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- MODE
    ins_left({
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
          gui = "bold"
        }
      end,
      padding = { left = 1, right = 1 },
    })

    -- FOLDER PATH (relative to cwd) in lualine_c
    ins_left({
      function()
        -- Get the relative path from the current file
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h"):sub(#vim.fn.getcwd() + 2)  -- Remove cwd prefix
      end,
      color = { fg = colors.cyan, gui = "bold" },
      cond = conditions.buffer_not_empty,
    })

    -- FILENAME (just the filename)
    ins_left({
      function()
        return vim.fn.expand('%:t') -- Only display the file name (not the full path)
      end,
      color = { fg = colors.magenta, gui = "bold" },
      cond = conditions.buffer_not_empty,
    })

    -- GIT BRANCH
    ins_left({
      "branch",
      icon = "",
      color = { fg = colors.magenta, gui = "bold" },
    })

    -- NAVIC BREADCRUMB (if available)
    ins_left({
      function()
        return navic.is_available() and navic.get_location() or ""
      end,
      color = { fg = colors.yellow },
      cond = function()
        return package.loaded["nvim-navic"] and navic.is_available()
      end,
    })

    -- DIAGNOSTICS (moved to the right)
    ins_right({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn  = { fg = colors.yellow },
        color_info  = { fg = colors.cyan },
      },
    })

    -- GIT DIFF (moved to the right)
    ins_right({
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = {
        added    = { fg = colors.green },
        modified = { fg = colors.orange },
        removed  = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    -- ALIGN RIGHT
    ins_right({ function() return "%=" end })

    require("lualine").setup(config)
  end,
}

