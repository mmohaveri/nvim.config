local Module = {}

Module.filetypes = { "html" }

Module.root_indicators = {
    "package.json",
    ".git",
}

Module.config = {
    name = "html",
    cmd = {
        "vscode-html-language-server",
        "--stdio",
    },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        configurationSection = {
            "html",
            "css",
            "javascript",
        },
    },
    settings = {},
}

Module.description = [[
Provides language server support for HTML files.
Uses [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted) which
can be installed via `npm`:

```sh
npm i -g vscode-langservers-extracted
```
]]

return Module
