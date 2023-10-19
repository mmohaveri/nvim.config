local Module = {}

Module.filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
}

Module.root_indicators = {
    ".git",
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
}

Module.config = {
    name = "typescript",
    cmd = {
        "typescript-language-server",
        "--stdio",
    },
    single_file_support = true,
    init_options = {
        hostInfo = "neovim",
    },
}

Module.description = [[
Provides language server support for JavaScript & TypeScript files.
Uses [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server)
which depends on typescript. Both can be installed via `npm`:

```sh
npm i -g typescript typescript-language-server
```
]]

return Module
