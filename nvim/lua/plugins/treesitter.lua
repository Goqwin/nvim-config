return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local uv = vim.loop

    local profiles = {
      fullstack = { "html", "typescript", "json", "python" },
      backend   = { "go" },
      arduino   = { "cpp" },
      oblivian  = { "markdown" },
      rust      = { "rust" },
    }

    local function detect_project()
      local function has(file)
        return uv.fs_stat(vim.loop.cwd() .. "/" .. file) ~= nil
      end

      if has("package.json") or has("index.html") then
        return "fullstack"
      elseif has("go.mod") then
        return "backend"
      elseif has("platformio.ini") or has("arduino.ino") then
        return "arduino"
      elseif has("README.md") then
        return "oblivian"
      elseif has("Cargo.toml") then
        return "rust"
      end
    end

    local function apply_profile(profile_key)
      local langs = profiles[profile_key]
      if not langs then
        vim.notify("❌ Treesitter profile not found: " .. profile_key, vim.log.levels.ERROR)
        return
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = langs,
        sync_install = true,
        highlight = {
          enable = true,
          disable = function(lang)
            return not vim.tbl_contains(langs, lang)
          end,
        },
        indent = {
          enable = true,
        },
      })
    vim.notify("✅ Treesitter profile loaded: " .. profile_key, vim.log.levels.INFO, {
    title = "Treesitter Profile",
  })
    end

    vim.api.nvim_create_user_command("TSProfileAuto", function()
      local detected = detect_project()
      if detected then
        apply_profile(detected)
      else
        vim.notify("⚠️ Could not auto-detect project type", vim.log.levels.WARN)
      end
    end, {})

    for key, _ in pairs(profiles) do
      local cmd_name = "TSProfile" .. key:sub(1, 1):upper() .. key:sub(2)
      vim.api.nvim_create_user_command(cmd_name, function()
        apply_profile(key)
      end, {})
    end

    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "python", "typescript", "rust", "json", "html" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
-- :TSProfileAuto
-- :TSProfileFullstack  # Applies the "fullstack" profile
-- :TSProfileRust       # Applies the "rust" profile
-- :TSProfileArduino    # Applies the "arduino" profile
