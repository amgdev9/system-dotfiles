-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable squiggle lines
vim.o.fillchars = 'eob: '

-- Disable swap files
vim.opt.swapfile = false
