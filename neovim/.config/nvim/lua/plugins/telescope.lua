return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  -- or branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local actions = require("telescope.actions")
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
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer, -- Delete buffer in insert mode
            },
            n = {
              ["<C-d>"] = actions.delete_buffer, -- Delete buffer in normal mode
            },
          },
        },
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
    vim.keymap.set("n", "<leader>fg", builtin.grep_string, { desc = "Telescope search text under cursor" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set(
      "n",
      "<leader>fi",
      builtin.current_buffer_fuzzy_find,
      { desc = "Telescope current buffer fuzzy find" }
    )
  end,
}
