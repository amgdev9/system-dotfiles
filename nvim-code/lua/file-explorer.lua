local oil = require("oil")
oil.setup({
    skip_confirm_for_simple_edits = false,
    keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = { "actions.parent", mode = "n" },
    },
    use_default_keymaps = false,
    view_options = {
        show_hidden = true,
    }   
})

vim.keymap.set("n", "<leader>e", function() 
    if vim.bo.filetype == "oil" then
        oil.close()
    else
        oil.open()      
    end
end)
