return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
    vim.keymap.set("n", "<leader>gl", ":LazyGitFilterCurrentFile<CR>", { desc = "Open log for current file" })
  end,
}
