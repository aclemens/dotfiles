-- tabs and indentations
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- ui and layout
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- file handling
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.swapfile = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- autofolding
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
