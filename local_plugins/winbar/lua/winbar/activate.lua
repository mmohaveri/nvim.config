---@class Icons
---@field file string
---@field seperator string
---@field modified string
---@field locked string
---@field help string

---@class Colors
---@field path string
---@field file_name string
---@field file_icon string
---@field symbols string
---@field active_bg string

---@class ActivateOptions
---@field colors Colors
---@field icons Icons
---@field exclude_filetype string[]

local highligh_groups = {
    path = "WinBarPath",
    file_name = "WinBarFile",
    symbols = "WinBarSymbols",
    file_icon = "WinBarFileIcon",
}

---@param icons Icons
local function get_tag(icons)
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

---@param icons Icons
local function get_winbar_pattern(icons)
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

        result = " %#" .. highligh_groups.symbols .. "#" .. get_tag(icons) .. " %*"
        result = result .. "%#" .. highligh_groups.path .. "#" .. file_path .. " %*"
        result = result .. "%#" .. highligh_groups.file_icon .. "#" .. file_icon .. " %*"
        result = result .. "%#" .. highligh_groups.file_name .. "#" .. file_name .. "%*"
    end

    return result
end

---@param exclude_filetype string[]
---@param icons Icons
local function update_winbar(exclude_filetype, icons)
    if vim.tbl_contains(exclude_filetype, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
    end

    pcall(vim.api.nvim_set_option_value, "winbar", get_winbar_pattern(icons), { scope = "local" })
end

---@param colors Colors
local function set_hightligh_groups(colors)
    vim.api.nvim_set_hl(0, highligh_groups.path, { fg = colors.path })
    vim.api.nvim_set_hl(0, highligh_groups.file_name, { fg = colors.file_name })
    vim.api.nvim_set_hl(0, highligh_groups.file_icon, { fg = colors.file_icon })
    vim.api.nvim_set_hl(0, highligh_groups.symbols, { fg = colors.symbols })
end

---@param options ActivateOptions
local function activate(options)
    set_hightligh_groups(options.colors)

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
        callback = function() update_winbar(options.exclude_filetype, options.icons) end,
    })
end

return activate
