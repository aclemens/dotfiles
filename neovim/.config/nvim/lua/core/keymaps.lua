-- map leader to SPACE
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap -- for conciseness

-- reset search highlight
keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- split windows
keymap.set('n', '<leader>sv', '<C-w>v') --split vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make split equal
keymap.set('n', '<leader>sx', '<cmd>close<CR>') -- close current

-- tab windows
keymap.set('n', '<leader>to', '<cmd>tabnew<CR>') -- open tab
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>') -- close tab
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>') -- previous tab
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>') -- next tab
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>') -- open current buffer in new tab

