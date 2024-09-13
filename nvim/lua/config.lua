-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Do not continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.o.signcolumn = "yes:1"

-- Disable squiggle lines
vim.o.fillchars = 'eob: '

-- Disable swap files
vim.opt.swapfile = false

