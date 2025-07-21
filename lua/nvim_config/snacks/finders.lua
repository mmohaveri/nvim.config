---@type snacks.picker.palette.finders
local M = {
    _palette_all_items_cache = {},
}

---@param items snacks.picker.PaletteItem[]
---@param parent_item? snacks.picker.PaletteItem
---@return snacks.picker.PaletteItem[]
local function collect_items(items, parent_item)
    local result = {}

    for _, item in ipairs(items) do
        item.parent = parent_item

        table.insert(result, item)

        -- Collect children
        if item.picker_opts and item.picker_opts.palette_items then
            local children = collect_items(item.picker_opts.palette_items, item)
            vim.list_extend(result, children)
        end
    end

    return result
end

function M.palette_items(opts, ctx)
    ---@cast opts snacks.picker.Palette.Config

    local all_items = M._palette_all_items_cache[opts.title]
    if all_items == nil then
        all_items = collect_items(opts.palette_items, nil)
        M._palette_all_items_cache[opts.title] = all_items
    end

    ---@type snacks.picker.PaletteItem[]
    local filtered_items = ctx.filter:filter(all_items)

    return filtered_items
end

return M
