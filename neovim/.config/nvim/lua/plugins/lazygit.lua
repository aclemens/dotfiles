return {
  "kdheepak/lazygit.nvim",

  config = function()
    vim.keymap.set('n', '<leader><leader>', ':LazyGit<CR>', { desc = "Open LazyGit" })
  end
}
