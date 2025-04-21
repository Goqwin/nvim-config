return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Custom theme with neon-glow vibes
    local cyberpunk = require("lualine.themes.onedark")

    cyberpunk.normal.a = { fg = "#0f0f1a", bg = "#FF00FF", gui = "bold" }   -- neon magenta
    cyberpunk.insert.a = { fg = "#0f0f1a", bg = "#00FFFF", gui = "bold" }  -- neon cyan
    cyberpunk.visual.a = { fg = "#0f0f1a", bg = "#FFD700", gui = "bold" }  -- neon yellow
    cyberpunk.replace.a = { fg = "#0f0f1a", bg = "#F7768E", gui = "bold" } -- hot pink
    cyberpunk.command.a = { fg = "#0f0f1a", bg = "#9ECE6A", gui = "bold" } -- lime green

    require("lualine").setup({
      options = {
        theme = cyberpunk,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,
                update_in_insert = true,
      },

      sections = {
        lualine_a = {
          { "mode", icon = "", fmt = function(str) return str:upper() end },
        },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "[No Name]",
            },
            icon = "",
          },
        },

        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = " ",
              warn  = " ",
              info  = " ",
              hint  = " ",
            },
            update_in_insert = true,
          },
          {
            function()
              local clients = vim.lsp.get_active_clients()
              if #clients > 0 then return "  LSP" else return "" end
            end,
          },
          "filetype",
        },

        lualine_y = {
          { "location", icon = "" },
        },

        lualine_z = {
          { "progress" },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { "nvim-tree", "quickfix", "toggleterm", "fugitive" },
    })
  end,
}

