local Module = {}

Module.filetypes = { "yaml", "yaml.docker-compose" }

Module.root_indicators = {
    ".git",
}

Module.config = {
    name = "yaml-language-server",
    cmd = {
        "yaml",
        "--stdio",
    },
    single_file_support = true,
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        yaml = {
            schemas = require("lsp_config.servers.jsonschema_mappings"),
        },
    },
}

Module.description = [[
Provides language server support for YAML files.
Uses [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
which can be installed via npm:

```sh
npm i -g yaml-language-server
```
]]

return Module
