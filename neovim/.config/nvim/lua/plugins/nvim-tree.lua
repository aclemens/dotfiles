return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      git = {
        ignore = false,
      }
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', {  desc = "Toggle the file explorer" })
    keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = "Toggle the file explorer and select the current file" })
  end
}
