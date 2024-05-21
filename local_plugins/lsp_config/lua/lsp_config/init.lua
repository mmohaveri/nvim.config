local Module = {}

function Module.setup()
    local lsp_setup = require("lsp_config.lsp_setup")
    local register_lsp = require("lsp_config.register_lsp")

    local lsp_servers = {
        -- "cssmodules_ls",
        -- "docker_compose_language_service",
        -- "dockerls",
        -- "golangci_lint_ls",
        -- "jqls",
        "css",
        "eslint",
        "go",
        "html",
        "json",
        "lua",
        "pyright",
        "ruff",
        "rust",
        "tex",
        "toml",
        "typescript",
        "vue",
        "yaml",
        -- "solc",
        -- "solidity",
        -- "sqlls",
        -- "texlab",
    }

    lsp_setup()
    for _, server_name in ipairs(lsp_servers) do
        local server_module = require("lsp_config.servers." .. server_name)
        register_lsp(server_module)
    end
end

return Module
