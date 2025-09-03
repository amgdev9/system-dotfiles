vim.cmd("colorscheme arctic")
vim.cmd("highlight Normal ctermbg=NONE guibg=NONE") -- Transparent background
vim.api.nvim_set_hl(0, "SignColumn", {bg="none"})

-- Icons
icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()
