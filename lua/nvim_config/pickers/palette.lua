local M = {}

---@class snacks.picker.PaletteItem: snacks.picker.finder.Item
---@field text string
---@field desc? string
---@field picker? string
---@field callback? string
---@field cmd? string

---@class snacks.picker.Palette.Config: snacks.picker.Config
---@field title string
---@field items snacks.picker.PaletteItem[]

---@param opts snacks.picker.Palette.Config
---@type snacks.picker.finder
local function palette_finder(opts, ctx)
    ---@type snacks.picker.PaletteItem[]
    return ctx.filter:filter(opts.items)
end

---@type  snacks.picker.format
local function palette_item_format(item, picker)
    local a = Snacks.picker.util.align
    ---@cast item snacks.picker.PaletteItem
    local ret = {} ---@type snacks.picker.Highlight[]

    ret[#ret + 1] = { a(item.text, 10), "SnacksPickerIconSource" }
    return ret
end

---@type snacks.picker.Action.spec
local function palette_action(picker, item, action)
    ---@cast item snacks.picker.PaletteItem
    picker:close()
    if item then
        if item.picker then
            require("snacks").picker[item.picker]()
        elseif item.callback then
            item.callback()
        elseif item.cmd then
            vim.cmd[item.cmd]()
        else
            vim.notify("No picker, callback, or cmd defined for '" .. item.text .. "'", vim.log.levels.ERROR)
        end
    end
end

---@param palette_name string
---@param items snacks.picker.PaletteItem[]
---@return snacks.picker.Palette.Config
function M.new(palette_name, items)
    ---@type snacks.picker.Palette.Config
    return {
        title = palette_name,
        finder = palette_finder,
        format = palette_item_format,
        layout = { preset = "vscode" },
        confirm = palette_action,
        matcher = {
            fuzzy = true,
            smartcase = true,
            sort_empty = false,
        },
        items = items,
    }
end

return M
