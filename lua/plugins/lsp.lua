return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      {"hrsh7th/cmp-buffer", event = "InsertEnter"},
    },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_servers = {
        rust_analyzer = false,
        gopls = false,
        pyright = true,
        ts_ls = true,
        lua_ls = true,
        eslint = true,
      }

      for server, is_enabled in pairs(lsp_servers) do
        if is_enabled then
          lspconfig[server].setup {
            on_attach = function(client, bufnr)
              local opts = { noremap = true, silent = true }
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
              buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
              buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              buf_set_keymap('i', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
              buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
              buf_set_keymap('n', '<leader>ws', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

              if client.name == "eslint" then
                client.server_capabilities.documentFormattingProvider = true
              elseif client.name == "ts_ls" then
                client.server_capabilities.documentFormattingProvider = false
              end
            end,
            settings = {
              pyright = { python = { analysis = { extraPaths = { "src", "third_party" } } } },
              rust_analyzer = { checkOnSave = { command = "clippy" } },
              ts_ls = { javascript = { suggest = { autoImports = true } } },
              lua_ls = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                },
              },
            },
          }
        end
      end

      function ToggleLSP(server)
        if lsp_servers[server] ~= nil then
          lsp_servers[server] = not lsp_servers[server]
          vim.notify(server .. " LSP " .. (lsp_servers[server] and "Enabled" or "Disabled"), vim.log.levels.INFO)
        else
          vim.notify("LSP Server " .. server .. " not found.", vim.log.levels.WARN)
        end
      end

      vim.api.nvim_create_user_command("ToggleLSP", function(args)
        ToggleLSP(args.args)
      end, { nargs = 1 })
    end,
  }
}
