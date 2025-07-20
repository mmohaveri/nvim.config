---@type snacks.picker.palette.finders
local M = {}

function M.palette_items(opts, ctx)
    ---@cast opts snacks.picker.Palette.Config

    local max_depth = 3 -- Set to -1 for unlimited recursion
    local indent_string = " - "

    local function collect_items(items, depth, current_indent)
        if max_depth ~= -1 and depth > max_depth then return {} end

        local result = {}

        for _, item in ipairs(items) do
            local display_item = vim.deepcopy(item)
            if current_indent ~= "" then display_item.text = current_indent .. display_item.text end
            table.insert(result, display_item)

            if item.picker_opts and item.picker_opts.palette_items then
                local nested_items =
                    collect_items(item.picker_opts.palette_items, depth + 1, current_indent .. indent_string)
                for _, nested_item in ipairs(nested_items) do
                    table.insert(result, nested_item)
                end
            end
        end

        return result
    end

    local all_items = collect_items(opts.palette_items, 0, "")

    ---@type snacks.picker.PaletteItem[]
    return ctx.filter:filter(all_items)
end

return M
