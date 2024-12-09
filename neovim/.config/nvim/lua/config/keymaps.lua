local keymap = vim.keymap -- for conciseness

-- reset search highlight
keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = "remove search highlight" })

-- split windows
keymap.set('n', '<leader>sv', '<C-w>v', { desc = "Split window vertically" })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = "Split window horizontally" })
keymap.set('n', '<leader>se', '<C-w>=', { desc = "Make split equal" })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = "close the current window" })

-- tab windows
keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = "open new tab" })
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = "close tab" })
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = "previous tab" })
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = "next tab" })
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = "open current buffer in new tab" })

