return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
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
        "taplo",
      },
    })
  end,
}
