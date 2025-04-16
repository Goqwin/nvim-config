return {
    "navarasu/onedark.nvim",
    config = function()
        require("onedark").setup({
            style = "deep",
            colors = {
                bright_orange = "#ff5f00",
                green = "#00ff9f",
                purple = "#bd00ff",
                blue = "#00aaff",
                pink = "#ff0080",
                cyan = "#00ffe0",
                yellow = "#ffdd00",
                bg = "#080d14",
                fg = "#d0d6e0",
            },
            highlights = {
                ["@keyword"] = { fg = "$green", bold = true },
                ["@string"] = { fg = "$bright_orange", bg = "#002200", fmt = "bold" },
                ["@function"] = { fg = "$blue", sp = "$cyan", fmt = "underline,italic" },
                ["@function.builtin"] = { fg = "$purple" },
                ["@comment"] = { fg = "#ff0080", italic = true },
                ["@type"] = { fg = "$yellow", bold = true },
            },
        })
        require("onedark").load()
        vim.cmd("colorscheme onedark")
    end
}
