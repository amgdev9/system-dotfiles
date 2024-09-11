local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { noremap = true, silent = true })
