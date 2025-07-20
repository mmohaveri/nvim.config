---@type snacks.picker.palette.finders
local M = {}

function M.palette_items(opts, ctx)
    ---@cast opts snacks.picker.Palette.Config
    ---@type snacks.picker.PaletteItem[]
    return ctx.filter:filter(opts.palette_items)
end

return M
