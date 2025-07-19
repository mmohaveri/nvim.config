---@class snacks.picker.palette.formatters
---@field [string] snacks.picker.format
local M = {}

function M.palette_item(item, picker)
    local a = require("snacks").picker.util.align
    ---@cast item snacks.picker.PaletteItem
    local ret = {} ---@type snacks.picker.Highlight[]

    ret[#ret + 1] = { a(item.text, 10), "SnacksPickerIconSource" }
    return ret
end

function M.icon_no_source(item, picker)
    local a = require("snacks").picker.util.align
    ---@cast item snacks.picker.Icon
    local ret = {} ---@type snacks.picker.Highlight[]

    ret[#ret + 1] = { a(item.icon, 3), "SnacksPickerIcon" }
    ret[#ret + 1] = { " " }
    ret[#ret + 1] = { a(item.name, 70), "SnacksPickerIconName" }
    ret[#ret + 1] = { " " }
    ret[#ret + 1] = { a(item.category, 8), "SnacksPickerIconCategory" }
    return ret
end

return M
