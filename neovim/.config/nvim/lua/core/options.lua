local opt = vim.opt -- for conciseness

-- tabs and indentations
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

-- ui and layout
opt.laststatus = 2
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- file handling
opt.autoread = true
opt.autowrite = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard

-- split windows
opt.splitright = true
opt.splitbelow = true

-- map leader to SPACE
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

