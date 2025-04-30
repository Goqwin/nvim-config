return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "ts_ls",
          "clangd",
          "gopls",
          "html",
          "marksman",
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = { allFeatures = true },
              diagnostics = { enable = true },
            },
          },
        },
        pyright = {},
        ts_ls = {},
        clangd = {},
        gopls = {},
        html = {},
        marksman = {},
      }

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[name].setup(config)
      end
    end,
  },
}
