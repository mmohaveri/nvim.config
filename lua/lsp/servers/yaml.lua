local Module = {}

Module.pattern = "yaml"
Module.root_indicators = {
    '.git',
}

Module.config = {
    name = "yaml-language-server",
    cmd = {
        "yaml-language-server",
        "--stdio",
    },
    filetypes = { 'yaml' },
    single_file_support = true,
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
}

return Module
