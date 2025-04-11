local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        kotlin = { "ktfmt" },
        swift = { "swiftformat" }
    },
})

function FormatCode()
    conform.format({ 
        async = true,
        lsp_format = "fallback"
    })
end

vim.api.nvim_set_keymap('n', '<leader>i', ':lua FormatCode()<CR>', { noremap = true, silent = true })

