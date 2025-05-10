return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "csharp_ls",
        "gopls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "taplo",
      },
    })
  end,
}
