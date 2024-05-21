local Module = {}

Module.filetypes = { "json", "jsonc" }

Module.root_indicators = {
    ".git",
}

Module.config = {
    name = "json",
    cmd = {
        "vscode-json-language-server",
        "--stdio",
    },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            schemas = require("lsp_config.servers.jsonschema_mappings"),
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

--   setup = {
--       commands = {
--           Format = {
--               function()
--                   vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
--               end,
--           },
--       },
--   },
