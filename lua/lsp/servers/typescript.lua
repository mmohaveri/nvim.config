local Module = {}

Module.pattern = "javascript"
Module.root_indicators = {
    ".git",
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
}

Module.config = {
    name = "typescript-language-server",
    cmd = {
        "typescript-language-server",
        "--stdio",
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    single_file_support = true,
    init_options = {
        hostInfo = "neovim",
    },
}

return Module
