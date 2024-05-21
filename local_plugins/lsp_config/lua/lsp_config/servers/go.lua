local Module = {}

Module.filetypes = { "go", "gomod", "gowork", "gotmpl" }

Module.root_indicators = {
    "go.work",
    "go.mod",
    ".git",
}

Module.config = {
    name = "go",
    cmd = {
        "gopls",
    },
    single_file_support = true,
}

Module.description = [[
Provides language server support for Go files.
Uses [gopls](https://github.com/golang/tools/tree/master/gopls)
which is the standard language server of Go. It can be installed via `go`:

```sh
go install gopls
```
]]

return Module
