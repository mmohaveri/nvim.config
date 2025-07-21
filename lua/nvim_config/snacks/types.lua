---@class snacks.picker.PaletteItem: snacks.picker.finder.Item
---@field text string
---@field desc? string
---@field picker? string
---@field picker_opts? table
---@field callback? string
---@field cmd? string
---@field parent? snacks.picker.PaletteItem

---@class snacks.picker.Palette.Config: snacks.picker.Config
---@field title string
---@field palette_items snacks.picker.PaletteItem[]

---@class snacks.picker.palette.actions
---@field [string] snacks.picker.Action.spec

---@class snacks.picker.palette.finders
---@field _palette_all_items_cache table<string, snacks.picker.PaletteItem[] | nil>
---@field [string] snacks.picker.finder

---@class snacks.picker.palette.formatters
---@field [string] snacks.picker.format
