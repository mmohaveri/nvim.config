local Module = {}

Module.filetypes = { "css", "scss", "less" }

Module.root_indicators = {
    "package.json",
    ".git",
}

Module.config = {
    name = "css",
    cmd = {
        "vscode-css-language-server",
        "--stdio",
    },
    single_file_support = true,
    settings = {
        css = {
            validate = true,
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    },
}

Module.description = [[
Provides language server support for CSS, SCSS, & LESS files.
Uses [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted) which
can be installed via `npm`:

```sh
npm i -g vscode-langservers-extracted
```
]]

return Module
