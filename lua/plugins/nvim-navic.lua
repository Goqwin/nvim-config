return {
  "SmiteshP/nvim-navic",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("nvim-navic").setup({
      highlight = true,
      separator = " > ", -- customize your breadcrumb style here
      depth_limit = 0, -- 0 = no limit
      icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = " ",
        Interface     = " ",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = " ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = " ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
      },
    })
  end,
}

