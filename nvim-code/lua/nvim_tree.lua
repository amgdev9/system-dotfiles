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

vim.api.nvim_set_keymap('n', '<leader>e', ':lua ToggleNvimTreeFocus()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':NvimTreeClose<CR>', { noremap = true, silent = true })

