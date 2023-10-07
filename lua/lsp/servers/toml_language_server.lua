local Module = {}

Module.pattern = "toml"
Module.root_indicators = {
    '.git',
}

Module.config = {
    name = "toml-language-server",
    cmd = {
        "taplo",
        "lsp",
        "stdio",
    },
    filetypes = { 'toml' },
    single_file_support = true,
}

return Module
