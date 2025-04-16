return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local on_attach = require("lsp.on_attach")

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
        },
      },
    })

    -- add more servers like tsserver, pyright, etc.
  end,
}

