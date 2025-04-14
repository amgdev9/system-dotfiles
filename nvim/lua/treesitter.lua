for ft, lang in pairs {
  automake = "make",
  javascriptreact = "javascript",
  ecma = "javascript",
  jsx = "javascript",
  gyp = "python",
  html_tags = "html",
  ["typescript.tsx"] = "tsx",
  ["terraform-vars"] = "terraform",
  ["html.handlebars"] = "glimmer",
  systemverilog = "verilog",
  dosini = "ini",
  confini = "ini",
  svg = "xml",
  xsd = "xml",
  xslt = "xml",
  expect = "tcl",
  mysql = "sql",
  sbt = "scala",
  neomuttrc = "muttrc",
  clientscript = "runescript",
  rs = "rust",
  ex = "elixir",
  js = "javascript",
  ts = "typescript",
  ["c-sharp"] = "csharp",
  hs = "haskell",
  py = "python",
  erl = "erlang",
  typ = "typst",
  pl = "perl",
  uxn = "uxntal",
  cs = "c_sharp",
  typescriptreact = "tsx",
} do
  vim.treesitter.language.register(lang, ft)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        -- Highlight using treesitter
        local filetype = args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if vim.treesitter.language.add(language) then
            vim.treesitter.start(args.buf)
        end

        -- Do not continue comments on new line
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end,
})

