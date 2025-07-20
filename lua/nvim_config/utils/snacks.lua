local M = {}

---@class gitmoji_data
---@field gitmojis {emoji: string, entity: string, code: string, description: string, name: string, semver: string|vim.NIL}[]

---@type {url: string, v:number, build: fun(data:table):snacks.picker.Icon[]}
local gitmoji_icon_source = {
    url = "https://raw.githubusercontent.com/carloscuesta/gitmoji/refs/heads/master/packages/gitmojis/src/gitmojis.json",
    v = 1,
    build = function(data)
        ---@cast data gitmoji_data
        local ret = {} ---@type snacks.picker.Icon[]
        for _, info in ipairs(data.gitmojis) do
            local category = info.semver
            if category == vim.NIL then category = "" end

            table.insert(ret, {
                name = info.description,
                icon = info.emoji,
                source = "gitmoji",
                category = category,
            })
        end
        return ret
    end,
}

function M.register_gitmoji_source_for_icons__picker()
    require("snacks.picker.source.icons").sources.gitmoji = gitmoji_icon_source
end

return M
