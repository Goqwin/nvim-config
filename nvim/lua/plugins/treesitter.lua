return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "bash", "json", "markdown",
        "html", "typescript", "python", "go", "rust"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

