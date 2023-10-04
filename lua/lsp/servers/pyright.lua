local Module = {}

Module.pattern = "python"
Module.root_indicators = {
    'pyproject.toml',
    'requirements.txt',
    'Pipfile',
}

Module.config = {
    name = "pyright",
    cmd = {
        "pyright-langserver",
        "--stdio",
    },
    filetypes = { 'python' },
    single_file_support = true,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
            },
        },
    },
}

return Module
