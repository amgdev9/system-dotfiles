local conform = require("conform")

local custom_ok, custom = pcall(require, "custom")

conform.setup({
    formatters_by_ft = custom_ok and custom.formatters_by_ft or {}
})

function FormatCode()
    conform.format({ 
        async = true,
        lsp_format = "fallback"
    })
end

vim.api.nvim_set_keymap('n', '<leader>i', ':lua FormatCode()<CR>', { noremap = true, silent = true })

