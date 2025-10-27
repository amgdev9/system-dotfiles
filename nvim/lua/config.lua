-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Colors
vim.opt.termguicolors = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- NO shada file
vim.opt.shada = ""

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true 

-- Sign column
vim.o.signcolumn = "yes:1"

-- Disable squiggle lines
vim.o.fillchars = 'eob: '

-- Disable swap files
vim.opt.swapfile = false

-- Dont continue comment lines
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
