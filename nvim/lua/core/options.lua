-- options.lua

-- General settings
local set = vim.opt

set.number = true                   -- Show line numbers
set.syntax = "on"                   -- Enable syntax highlighting
set.tabstop = 4                     -- Tab width
set.shiftwidth = 4                  -- Indentation width
set.expandtab = true                -- Use spaces instead of tabs
set.smartindent = true              -- Enable smart indentation
set.wrap = false                    -- Disable line wrapping
set.cursorline = true               -- Highlight current line

-- Search settings
set.ignorecase = true               -- Ignore case in search
set.smartcase = true                -- Case-sensitive search if input has uppercase
set.incsearch = true                -- Incremental search
set.hlsearch = false                -- Disable search highlights

-- Backup and undo settings
set.backup = false                  -- Disable backup
set.writebackup = false             -- Disable write backup
set.undofile = true                 -- Enable undo file
set.swapfile = false                -- Disable swap file

-- UI settings
set.scrolloff = 8                   -- Keep 8 lines visible when scrolling
set.sidescrolloff = 8               -- Horizontal scroll offset
set.termguicolors = true            -- Enable true color support
set.signcolumn = "yes"              -- Always show the sign column
set.splitright = true               -- Split vertical windows to the right
set.splitbelow = true               -- Split horizontal windows below

-- Performance settings
set.updatetime = 300                -- Faster completion
set.timeoutlen = 500                -- Timeout length for mappings

-- File encoding settings
set.fileencoding = "utf-8"          -- Default file encoding
