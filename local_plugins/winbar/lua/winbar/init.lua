local Module = {}

local default_colors = {
    path = "#7c7c7c",
    file_name = "#ffffff",
    file_icon = "#4b93bf",
    symbols = "#e14c12",
    active_bg = "#3b3b3b",
}

local default_icons = {
    file = "",
    seperator = ">",
    modified = "󰏬",
    locked = "",
    help = "󰞋",
}

local default_exclude_filetype = {
    "NvimTree",
    "DressingInput",
    "undotree",
    "toggleterm",
    "TelescopePrompt",
    "buffer_manager",
}

Module.setup = function()
    local activate = require("winbar.activate")

    activate({
        colors = default_colors,
        icons = default_icons,
        exclude_filetype = default_exclude_filetype,
    })
end

return Module
