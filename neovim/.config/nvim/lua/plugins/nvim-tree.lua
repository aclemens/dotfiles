return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvtree.setup({
      git = {
        ignore = false,
      }
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>')
    keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>')
  end
}
