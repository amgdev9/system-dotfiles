local safe_require = require("utils").safe_require
local flags = safe_require("flags")

vim.g.loaded_netrw = 1	-- Using nvim-tree as a file explorer
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("package-manager")
require("remaps")
require("telescope")
require("tree-sitter")
require("autocomplete")
require("lsp")
require("config")
require("nvim_tree")
require("color-scheme")
require("status-bar")
require("diagnostics")

if flags ~= nil and flags.flutter then
    require("flutter")
end
