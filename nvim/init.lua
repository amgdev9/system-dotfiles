vim.opt.rtp:append("~/.config/nvim/plugins/*")

require("config")
require("remaps")
require("git-gutter")
require("autocomplete")
require("lsp")
require("format")
require("nvim_tree")
require("color-scheme")
require("status-bar")
require("finder")
require("codeium").setup({})

