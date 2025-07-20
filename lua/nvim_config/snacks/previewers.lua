local M = {}

local mode_map = {
    n = "Normal",
    v = "Visual & Select",
    x = "Visual",
    s = "Select",
    o = "Operator Pending",
    [""] = "Normal, Visual, Select, Operator Pending",
    [" "] = "Normal, Visual, Select, Operator Pending",
    ["!"] = "Insert & Command",
    ic = "Insert & Command",
    i = "Insert",
    l = "Insert, Command, Lang-Arg",
    c = "Command",
    t = "Terminal",
}

function M.keymaps(ctx)
    local km = ctx.item.item
    local lines = {}
    local mode = "No Mode!"
    if km.mode then mode = mode_map[km.mode] or ("Unknown Mode: `" .. km.mode .. "`") end

    table.insert(lines, "Key:\t\t\t" .. km.lhs)
    table.insert(lines, "Mode:\t\t\t" .. mode)
    if km.desc and km.desc ~= "" then
        table.insert(lines, "Description: \t" .. km.desc)
    else
        table.insert(lines, "No description available")
    end

    table.insert(lines, "")

    if km.rhs then table.insert(lines, "Command: " .. km.rhs) end

    if km.buffer or (km.buffer ~= 0) then
        table.insert(lines, "Local binding")
    else
        table.insert(lines, "Global binding")
    end

    local flags = {}
    if km.nowait == 1 then table.insert(flags, "nowait") end
    if km.silent == 1 then table.insert(flags, "silent") end
    if km.expr == 1 then table.insert(flags, "expr") end
    if #flags > 0 then table.insert(lines, "Flags: " .. table.concat(flags, ", ")) end

    ctx.item.preview = {
        text = table.concat(lines, "\n"),
        ft = "text",
        loc = false,
    }

    return require("snacks.picker.preview").preview(ctx)
end

return M
