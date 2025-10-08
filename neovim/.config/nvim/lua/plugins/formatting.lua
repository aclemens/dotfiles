return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        htmlangular = { "prettier" },
        bash = { "shfmt" },
        css = { "prettier" },
        go = { "gofmt" },
        graphql = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "ruff_fix", "ruff_format" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 5000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
