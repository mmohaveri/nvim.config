local Module = {}

Module.pattern = "python"
Module.root_indicators = {
    'pyproject.toml',
    'requirements.txt',
    'Pipfile',
}

Module.config = {
    name = "ruff",
    cmd = {
        "ruff-lsp",
    },
    filetypes = { 'python' },
    single_file_support = true,
    settings = {},
}

return Module
