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

    local function collect_items(items, depth, current_prefix, parent_item, parent_sort)
        if max_depth ~= -1 and depth > max_depth then return {} end

        local result = {}

        for i, item in ipairs(items) do
            local is_last = i == #items

            -- Create a copy of the item with parent reference and hierarchical sort
            local current_item = vim.deepcopy(item)
            current_item.parent = parent_item

            -- Add hierarchical sort field (parents before children)
            local sort_prefix = parent_sort or ""
            if current_item.picker_opts and current_item.picker_opts.palette_items then
                -- This is a parent item - use "!" prefix to sort before children
                current_item.sort = sort_prefix .. string.format("!%03d", i)
            else
                -- This is a child item - use "#" prefix to sort after parents
                current_item.sort = sort_prefix .. string.format("#%03d", i)
            end

            -- Add the item with tree formatting
            local display_item = vim.deepcopy(current_item)
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

            -- Collect children
            if item.picker_opts and item.picker_opts.palette_items then
                local next_prefix = current_prefix
                if depth > 0 then
                    if is_last then
                        next_prefix = next_prefix .. tree_symbols.empty
                    else
                        next_prefix = next_prefix .. tree_symbols.vertical
                    end
                end

                local children = collect_items(
                    item.picker_opts.palette_items,
                    depth + 1,
                    next_prefix,
                    current_item,
                    current_item.sort .. " "
                )
                for _, child in ipairs(children) do
                    table.insert(result, child)
                end
            end
        end

        return result
    end

    local all_items = collect_items(opts.palette_items, 0, "", nil, "")

    ---@type snacks.picker.PaletteItem[]
    return ctx.filter:filter(all_items)
end

return M
