vim.g.mapleader = " "
vim.api.nvim_set_keymap("", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("Rexplore")
  else
    vim.cmd("Explore")
  end
end)
