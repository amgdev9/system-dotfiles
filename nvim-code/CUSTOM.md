- Create a `lua/custom.lua` file and return a table like this

```lua
return {
   lsp = { "pyright", kotlin = { "lsp-exec-file-path" } },
   formatters_by_ft = { kotlin = "ktfmt" }
}
```
