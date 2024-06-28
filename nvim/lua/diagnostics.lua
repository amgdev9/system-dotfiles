vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})
vim.keymap.set('', '<leader>l', ":lua vim.diagnostic.open_float()<CR>")

