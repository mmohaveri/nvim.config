local Module = {}

local file_tree_name_prefix = "NvimTree_"

Module.winbar_tag = function ()
    local modified_flag = vim.api.nvim_eval_statusline("%M", {}).str == "+"
    local readonly_flag = vim.api.nvim_eval_statusline("%R", {}).str == "RO"
    local help_flag = vim.api.nvim_eval_statusline("%H", {}).str == "HLP"

    local tag = ""
    if modified_flag then
        tag = "⊚ "
    elseif help_flag then
        tag = "︖ "
    elseif readonly_flag then
        tag = "🔒 "
    end

    return tag
end

Module.winbar_path = function ()
    local file_path = vim.api.nvim_eval_statusline("%f", {}).str
    local file_name = vim.api.nvim_eval_statusline("%t", {}).str

    file_path = file_path:gsub("/", " ⮞ ")
    file_path = file_path:gsub(file_name, "")

    return file_path
end

Module.winbar_file = function ()
    local file_path = vim.api.nvim_eval_statusline("%f", {}).str

    -- Do not show WinBar for the file tree
    local is_nvim_tree = string.sub(file_path, 1, #file_tree_name_prefix) == file_tree_name_prefix
    if is_nvim_tree then return "" end

    local file_name = vim.api.nvim_eval_statusline("%t", {}).str

    return file_name
end


return Module
