return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua", "vim", "vimdoc", "markdown_inline"},  -- Specify parsers
            highlight = { enable = true }, -- Enable syntax highlighting
        }
    end
	}







	-- Future Use case Advanced Modules nvim-treesitter.define_modules
	-- if I'm going to use custom languages 
	-- under setup lang_plugin = {
		-- attach = function (bufnr, lang)
			-- ...implement here
			-- end,
		-- detach = function (bufnr,lang)
			-- ... undo here
			-- end,
			--is_supported = function(lang)
				--conditions to check if lang works
				--end,

