function FormatCode()
    local filetype = vim.bo.filetype
    if (filetype == 'kotlin') then
        local current_buffer = vim.api.nvim_get_current_buf()
        local buf_content = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)

        local content = table.concat(buf_content, "\n")

        local handle = io.popen("echo '" .. content .. "' | ktfmt --kotlinlang-style -")
        local formatted_content = handle:read("*all")
        handle:close()

        vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, vim.fn.split(formatted_content, "\n"))
    else
        vim.lsp.buf.format({ 
            async = true,
            filter = function(client)
                return client.name == "biome"
            end
        })
    end
end

vim.api.nvim_set_keymap('n', '<leader>i', ':lua FormatCode()<CR>', { noremap = true, silent = true })

