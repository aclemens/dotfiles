vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup()

local keymap = vim.keymap -- for conciseness

keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>')
keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>')
