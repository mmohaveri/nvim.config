local Module = {}

local path_utils = require("lsp_config.utils.path")

function Module.get_active_client_by_name(bufnr, server_name)
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
        if client.name == server_name then return client end
    end

    vim.notify("No LSP client with name '" .. server_name .. "' is attached to this buffer.", vim.log.levels.ERROR)
end

function Module.validate_bufnr(bufnr)
    vim.validate({
        bufnr = { bufnr, "n" },
    })

    return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
end

function Module.is_part_of_vue_project(file_path)
    local vue_project_indicators = {
        "app.vue",
        "nuxt.config.ts",
        "nuxt.config.js",
    }

    local function check_dir_for_vue_indicators(path)
        for _, vue_indicator in ipairs(vue_project_indicators) do
            local full_path = path_utils.join(path, vue_indicator)
            if path_utils.exists(full_path) then return true end
        end

        return false
    end

    return path_utils.search_ancestors(file_path, check_dir_for_vue_indicators)
end

return Module
