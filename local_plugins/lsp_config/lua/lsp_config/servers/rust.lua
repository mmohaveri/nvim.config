local Module = {}

local lsp = require("lsp_config.utils.lsp")
local function reload_workspace(bufnr)
    bufnr = lsp.validate_bufnr(bufnr)
    local clients = vim.lsp.get_active_clients({ name = "rust_analyzer", bufnr = bufnr })
    for _, client in ipairs(clients) do
        vim.notify("Reloading Cargo Workspace", vim.log.levels.INFO)
        client.request("rust-analyzer/reloadWorkspace", nil, function(err)
            if err then vim.notify(tostring(err), vim.log.levels.ERROR) end
            vim.notify("Cargo workspace reloaded", vim.log.levels.INFO)
        end, 0)
    end
end

local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.experimental = {
        serverStatusNotification = true,
    }
    return capabilities
end

Module.filetypes = { "rust" }

Module.root_indicators = {
    "cargo.toml",
    ".git",
}

Module.config = {
    name = "rust",
    cmd = {
        "rust-analyzer",
    },
    capabilities = get_capabilities(),
    commands = {
        CargoReload = {
            function() reload_workspace(0) end,
            description = "Reload current cargo workspace",
        },
    },
}

Module.description = [[
Provides language server support for rust files.
Uses rust-analyzer which is installed as part of an standard rust installation.
]]

return Module
