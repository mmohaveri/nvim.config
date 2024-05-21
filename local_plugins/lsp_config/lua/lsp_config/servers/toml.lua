local Module = {}

Module.filetypes = { "toml" }

Module.root_indicators = {
    ".git",
}

Module.config = {
    name = "toml",
    cmd = {
        "taplo",
        "lsp",
        "stdio",
    },
    single_file_support = true,
}

Module.description = [[
Provides language server support for TOML files.
Uses [Taplo language server](https://taplo.tamasfe.dev) which can be installed
via cargo:

```sh
cargo install --features lsp --locked taplo-cli
```
]]

return Module
