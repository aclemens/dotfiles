return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "ellisonleao/gruvbox.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "gruvbox",
      },
    })
  end,
}
