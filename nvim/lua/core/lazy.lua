-- ~/.config/nvim/lua/core/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.colorscheme"),
  require("plugins.lsp"),
  require("plugins.cmp"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.dap"),
  require("plugins.git"),
  require("plugins.lualine"),
  require("plugins.nvimtree"),
})
