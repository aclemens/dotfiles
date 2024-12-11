return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  -- or branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Include hidden files
          "--glob=!.git/*", -- Optional: Exclude .git folder
        },
        hidden = true,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          hidden = true,
        },
      },
    })

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
  end,
}
