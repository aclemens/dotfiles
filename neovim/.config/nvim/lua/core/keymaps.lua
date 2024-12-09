-- map leader to SPACE
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap -- for conciseness

keymap.set('n', '<leader>h', ':nohlsearch<CR>')

