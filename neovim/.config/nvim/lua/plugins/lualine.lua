return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "folke/tokyonight.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight",
      },
    })
  end,
}
