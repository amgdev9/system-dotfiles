require("nvim-tree").setup({
    git = {
        ignore = false
    },
    renderer = {
        highlight_git = true,
        icons = {
            glyphs = {
                git = {
                    unstaged = "M",
                    staged = "A",
                    unmerged = "!",
                    renamed = "R",
                    untracked = "U",
                    deleted = "D",
                    ignored = ""
                }
            }
        }
    },
    filesystem_watchers = { -- This avoids hang on quit
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
            "/.ccls-cache",
            "/build",
            "/node_modules",
            "/target",
        },
    },
    update_focused_file = {
        enable = true,
    }
})

function ToggleNvimTreeFocus()
    local lib = require'nvim-tree.lib'
    local view = require'nvim-tree.view'
    if view.is_visible() then
        local current_window = vim.api.nvim_get_current_win()
        local nvim_tree_window = view.get_winnr()
        if current_window == nvim_tree_window then
            vim.cmd('wincmd w')
        else
            vim.cmd('NvimTreeFocus')
        end
    else
        vim.cmd('NvimTreeToggle')
    end
end

function FormatCode()
    local filetype = vim.bo.filetype
    if vim.fn.exists(':EslintFixAll') > 0 and (filetype == 'javascript' or filetype == 'typescript' or filetype == 'javascriptreact' or filetype == 'typescriptreact') then
        vim.cmd('EslintFixAll')
    elseif (filetype == 'kotlin') then
        local current_buffer = vim.api.nvim_get_current_buf()
        local buf_content = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)

        local content = table.concat(buf_content, "\n")

        local handle = io.popen("echo '" .. content .. "' | ktfmt --kotlinlang-style -")
        local formatted_content = handle:read("*all")
        handle:close()

        vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, vim.fn.split(formatted_content, "\n"))
    else
        vim.lsp.buf.format({ async = true })
    end
end

vim.api.nvim_set_keymap('n', '<leader>e', ':lua ToggleNvimTreeFocus()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>i', ':lua FormatCode()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':NvimTreeClose<CR>', { noremap = true, silent = true })

