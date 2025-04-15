return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua" },  -- Specify parsers
            highlight = { enable = true }, -- Enable syntax highlighting
        }
    end
	}

