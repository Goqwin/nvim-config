return {
  "navarasu/onedark.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("onedark").setup({
      style = "deep",
      transparent = false,
      term_colors = true,
      code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'italic,bold',
        strings = 'none',
        variables = 'none'
      },
      highlights = {
        ["@function"]      = { fg = "#00FFFF", fmt = "italic,bold" },
        ["@variable"]      = { fg = "#FF9E64" },
        ["@number"]        = { fg = "#F7768E" },
        ["@string"]        = { fg = "#9ECE6A" },
        ["@keyword"]       = { fg = "#BB9AF7", fmt = "bold" },
        ["@comment"]       = { fg = "#5C6370", fmt = "italic" },
      },
    })
    require("onedark").load()
  end,
}

