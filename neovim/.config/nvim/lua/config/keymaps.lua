-- reset search highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = "remove search highlight" })

-- split windows
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = "Split window vertically" })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = "Split window horizontally" })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = "Make split equal" })
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = "close the current window" })

-- tab windows
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = "open new tab" })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = "close tab" })
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = "previous tab" })
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = "next tab" })
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = "open current buffer in new tab" })

