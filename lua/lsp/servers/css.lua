local Module = {}

Module.pattern = "css"
Module.root_indicators = {
    '.git',
}

Module.config = {
    name = "css-language-server",
    cmd = {
        "vscode-css-language-server",
        "--stdio",
    },
    filetypes = { "css", "scss", "less" },
    single_file_support = true,
    settings = {
        css = {
            validate = true,
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    },
}

return Module

