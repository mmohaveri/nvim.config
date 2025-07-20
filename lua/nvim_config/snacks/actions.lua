---@type snacks.picker.palette.actions
local M = {}

function M.palette_item(picker, item, action)
    ---@cast item snacks.picker.PaletteItem

    picker:close()
    if item then
        if item.picker then
            require("snacks").picker[item.picker](item.picker_opts)
        elseif item.picker_opts then
            require("snacks").picker(item.picker_opts)
        elseif item.callback then
            item.callback()
        elseif item.cmd then
            vim.cmd[item.cmd]()
        else
            vim.notify("No picker, callback, or cmd defined for '" .. item.text .. "'", vim.log.levels.ERROR)
        end
    end
end

return M
