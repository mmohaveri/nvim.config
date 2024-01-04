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
    name = "ruff",
    cmd = {
        "ruff-lsp",
    },
    single_file_support = true,
    init_options = {
        settings = {
            args = {}, -- extra CLI arguments for ruff
        },
    },
    settings = {},
}

Module.description = [[
Provides linting for python files.
Uses [ruff-lsp](vscode-langservers-extracted) which uses `ruff` behind the scene.
It can be installed via `pip`:

```sh
pip install ruff-lsp
```
]]

return Module
