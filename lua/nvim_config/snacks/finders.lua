---@type snacks.picker.palette.finders
local M = {}

function M.palette_items(opts, ctx)
    ---@cast opts snacks.picker.Palette.Config

    local max_depth = 3 -- Set to -1 for unlimited recursion

    local tree_symbols = {
        vertical = "│ ",
        middle = "├╴",
        last = "└╴",
        empty = "  ",
    }

    local function collect_items(items, depth, current_prefix, is_last_at_level)
        if max_depth ~= -1 and depth > max_depth then return {} end

        local result = {}

        for i, item in ipairs(items) do
            local is_last = i == #items
            local display_item = vim.deepcopy(item)

            if depth > 0 then
                local prefix = current_prefix
                if is_last then
                    prefix = prefix .. tree_symbols.last
                else
                    prefix = prefix .. tree_symbols.middle
                end
                display_item.text = prefix .. display_item.text
            end

            table.insert(result, display_item)

            if item.picker_opts and item.picker_opts.palette_items then
                local next_prefix = current_prefix
                if depth > 0 then
                    if is_last then
                        next_prefix = next_prefix .. tree_symbols.empty
                    else
                        next_prefix = next_prefix .. tree_symbols.vertical
                    end
                end

                local nested_items = collect_items(item.picker_opts.palette_items, depth + 1, next_prefix, is_last)
                for _, nested_item in ipairs(nested_items) do
                    table.insert(result, nested_item)
                end
            end
        end

        return result
    end

    local all_items = collect_items(opts.palette_items, 0, "", false)

    ---@type snacks.picker.PaletteItem[]
    return ctx.filter:filter(all_items)
end

return M
