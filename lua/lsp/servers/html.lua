local Module = {}

Module.pattern = "html"
Module.root_indicators = {
    '.git',
}

Module.config = {
    name = "html-language-server",
    cmd = {
        "vscode-html-language-server",
        "--stdio",
    },
    filetypes = { "html" },
    single_file_support = true,
    init_options = {
        provideFormatter = true,
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        configurationSection = {
            "html",
            "css",
            "javascript",
        }
    },
    settings = {},
}

return Module

