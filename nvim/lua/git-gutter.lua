local minidiff = require("mini.diff")
minidiff.setup()

vim.keymap.set("n", "<leader>h", function()
    minidiff.toggle_overlay()
end)

