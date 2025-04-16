return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",     -- Lua
          "tsserver",   -- JavaScript/TypeScript
          "pyright",    -- Python
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local on_attach = require("lsp.on_attach")

      -- Automatically set up handlers for all installed servers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
          })
        end,
      })
    end,
  },
}

