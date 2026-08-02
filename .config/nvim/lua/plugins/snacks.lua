return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          auto_close = true,
        },
      },
      layout = {
        preset = "select",
        -- layout = {
        --   box = "vertical",
        --   backdrop = false,
        --   width = 0.5,
        --   height = 0.8,
        --   border = "none",
        --   {
        --     win = "preview",
        --     title = "{preview:Preview}",
        --     height = 0.45,
        --     border = true,
        --     title_pos = "center",
        --   },
        --
        --   {
        --     box = "vertical",
        --     {
        --       win = "list",
        --       title = " Results ",
        --       title_pos = "center",
        --       border = true,
        --     },
        --     {
        --       win = "input",
        --       height = 1,
        --       border = true,
        --       title = "{title} {live} {flags}",
        --       title_pos = "center",
        --     },
        --   },
        -- },
      },
    },
  },
}
