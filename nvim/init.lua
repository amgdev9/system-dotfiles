local safe_require = require("utils").safe_require
local flags = safe_require("flags")

vim.g.loaded_netrw = 1	-- Using nvim-tree as a file explorer
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("package-manager")
require("config")
require("remaps")
require("git-gutter")
require("tree-sitter")
require("autocomplete")
require("lsp")
require("nvim_tree")
require("color-scheme")
require("status-bar")
require("finder")
require("ai")

if flags ~= nil and flags.flutter then
    require("flutter")
end

if flags ~= nil and flags.xcode then
    require("xcode")
end

