local Module = {}

local schemas = require("lsp.servers.json_schema_mappings")

Module.pattern = "json"
Module.root_indicators = {
    '.git',
}

Module.config = {
    name = "json-language-server",
    cmd = {
        "vscode-json-language-server",
        "--stdio",
    },
    filetypes = { 'json' },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            schemas = schemas,
        },
    },
}

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
