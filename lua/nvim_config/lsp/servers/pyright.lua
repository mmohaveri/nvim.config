local Module = {}

Module.filetypes = { "python" }

Module.root_indicators = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
}

Module.config = {
    name = "pyright",
    cmd = {
        "pyright-langserver",
        "--stdio",
    },
    single_file_support = true,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
    commands = {
        PyrightOrganizeImports = {
            function()
                local params = {
                    command = "pyright.organizeimports",
                    arguments = {
                        vim.uri_from_bufnr(0),
                    },
                }
                vim.lsp.buf.execute_command(params)
            end,
            description = "Organize imports using pyright",
        },
    },
}

Module.description = [[
Provides langserver support for Python files.
Uses [pyright](https://github.com/microsoft/pyright) which can be installed via pip:

```sh
pip install pyright
```
]]

return Module
