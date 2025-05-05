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
          "tsserver",        
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
              checkOnSave = true,
              cargo = { allFeatures = true },
              diagnostics = { enable = true },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "strict", 
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        tsserver = {
          settings = {
            javascript = {
              format = { enable = true },
            },
            typescript = {
              format = { enable = true },
            },
          },
        },
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
        },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        html = {
          settings = {
            html = {
              format = { enable = true },
            },
          },
        },
        marksman = {
          settings = {
            marksman = {
              linter = true,
            },
          },
        },
      }

      
      for name, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[name].setup(config)
      end

      
      vim.diagnostic.config({
        virtual_text = true,  
        signs = true,         
        underline = true,     
        update_in_insert = true,
        severity_sort = true,
      })
    end,
  },
}

