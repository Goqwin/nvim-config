return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup()

    local ts_profiles = {
      fullstack = { "html", "typescript", "json", "python" },
      backend   = { "go" },
      arduino   = { "cpp" },
      oblivian  = { "markdown" },
      rust      = { "rust" },
    }

    vim.api.nvim_create_user_command("TSProfilePicker", function()
      local has_telescope, telescope = pcall(require, "telescope")
      if not has_telescope then
        vim.notify("Telescope not found", vim.log.levels.ERROR)
        return
      end

      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local conf = require("telescope.config").values

      local profile_names = vim.tbl_keys(ts_profiles)

      pickers.new({}, {
        prompt_title = "Select Treesitter Profile",
        finder = finders.new_table {
          results = profile_names,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()[1]
            actions.close(prompt_bufnr)

            local langs = ts_profiles[selection]
            if langs then
              require("nvim-treesitter.configs").setup({
                ensure_installed = langs,
                sync_install = true,
                highlight = {
                  enable = true,
                  disable = function(lang)
                    return not vim.tbl_contains(langs, lang)
                  end,
                },
                indent = { enable = true },
              })

              vim.notify("✅ Treesitter profile selected: " .. selection, vim.log.levels.INFO, {
                title = "Telescope TSProfile",
              })
            end
          end)
          return true
        end,
      }):find()
    end, {})
  end,
}
-- Run the following commands: :TSProfilePicker  select setup. 
