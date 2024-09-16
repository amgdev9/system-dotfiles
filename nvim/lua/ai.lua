require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    agent = {
      adapter = "copilot",
    },
  },
})

vim.api.nvim_set_keymap("n", "<leader>c", ":CodeCompanionChat<CR>", { noremap = true, silent = true })
