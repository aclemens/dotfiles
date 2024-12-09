return {
  "nvim-lualine/lualine.nvim",
  dependencies = "ellisonleao/gruvbox.nvim",

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "gruvbox"
      }
    })
  end
}
