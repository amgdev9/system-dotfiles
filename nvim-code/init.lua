vim.opt.rtp:append("~/.config/nvim-code/plugins/*")

-- Common config
require("config")
require("remaps")

-- Coding config
require("color-scheme")
require("finder")
require("status-bar")
require("file-explorer")
require("git-gutter")
require("ai")
require("format")
require("autocomplete")
require("lsp")
require("treesitter")
require("harpoon-config")
