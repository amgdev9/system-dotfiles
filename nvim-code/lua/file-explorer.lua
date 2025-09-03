require("oil").setup({
    skip_confirm_for_simple_edits = false,
    keymaps = {
        ["<CR>"] = "actions.select",
        ["<leader>e"] = { "actions.toggle_hidden", mode = "n" },
    },
    use_default_keymaps = false,
    view_options = {
        show_hidden = true,
    }   
})

