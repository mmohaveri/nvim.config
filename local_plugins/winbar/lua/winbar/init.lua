local Module = {}

local icons = {
    file = "",
    seperator = "⮞",
    modified = "󰏬",
    locked = "",
    help = "󰞋",
}

local highligh_groups = {
    path = "WinBarPath",
    file_name = "WinBarFile",
    symbols = "WinBarSymbols",
    file_icon = "WinBarFileIcon",
}

local colors = {
    path = "#7c7c7c",
    file_name = "#ffffff",
    file_icon = "#4b93bf",
    symbols = "#e14c12",
    active_bg = "#3b3b3b",
    deactive_bg = nil,
}

local exclude_filetype = {
    "NvimTree",
    "DressingInput",
    "undotree",
    "toggleterm",
    "TelescopePrompt",
}

local function get_tag()
    local help_flag = vim.api.nvim_eval_statusline("%H", {}).str == "HLP"

    local tag = ""
    if vim.api.nvim_buf_get_option(0, "mod") then
        tag = icons.modified
    elseif help_flag then
        tag = icons.help
    elseif vim.api.nvim_buf_get_option(0, "readonly") then
        tag = icons.locked
    end

    return tag
end

local function get_value()
    local file_path = vim.fn.expand("%:~:.:h")
    local file_name = vim.fn.expand("%:t")
    local file_type = vim.fn.expand("%:e")
    local file_icon = ""
    local result = ""

    highligh_groups.file_icon = "DevIcon" .. file_type

    file_path = file_path:gsub("^%.", "")
    file_path = file_path:gsub("^%/", "")
    file_path = file_path:gsub("/", " " .. icons.seperator .. " ")

    if file_name ~= nil and file_name ~= "" then
        local default = false

        if file_type == nil or file_type == "" then
            file_type = ""
            default = true
        end

        local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")

        if web_devicons_ok then file_icon = web_devicons.get_icon(file_name, file_type, { default = default }) end

        if not file_icon then file_icon = icons.file end

        result = " %#" .. highligh_groups.symbols .. "#" .. get_tag() .. " %*"
        result = result .. "%#" .. highligh_groups.path .. "#" .. file_path .. " %*"
        result = result .. "%#" .. highligh_groups.file_icon .. "#" .. file_icon .. " %*"
        result = result .. "%#" .. highligh_groups.file_name .. "#" .. file_name .. "%*"
    end

    return result
end

local function update_winbar()
    if vim.tbl_contains(exclude_filetype, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
    end

    pcall(vim.api.nvim_set_option_value, "winbar", get_value(), { scope = "local" })
end

Module.setup = function()
    vim.api.nvim_set_hl(0, highligh_groups.path, { fg = colors.path })
    vim.api.nvim_set_hl(0, highligh_groups.file_name, { fg = colors.file_name })
    vim.api.nvim_set_hl(0, highligh_groups.file_icon, { fg = colors.file_icon })
    vim.api.nvim_set_hl(0, highligh_groups.symbols, { fg = colors.symbols })

    vim.api.nvim_create_autocmd({
        "DirChanged",
        "BufWinEnter",
        "BufFilePost",
        "BufWritePost",
        "WinEnter",
        "WinLeave",
        "ModeChanged",
        "TextChanged",
        "TextChangedI",
    }, {
        callback = update_winbar,
    })
end

return Module
