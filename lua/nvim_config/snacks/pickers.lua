---@class snacks.picker.Palette
---@field [string] snacks.picker.Palette.Config
local M = {}

---@param palette_name string
---@param items snacks.picker.PaletteItem[]
---@return snacks.picker.Palette.Config
local function new_palette(palette_name, items)
    ---@type snacks.picker.Palette.Config
    return {
        title = palette_name,
        finder = require("nvim_config.snacks.finders").palette_items,
        format = require("nvim_config.snacks.formatters").palette_item,
        layout = { preset = "vscode" },
        confirm = require("nvim_config.snacks.actions").palette_item,
        matcher = {
            fuzzy = true,
            smartcase = true,
            sort_empty = false,
        },
        palette_items = items,
    }
end

M.command_palette = new_palette("Command Palette", {
    {
        text = "Auto Commands",
        picker = "autocmds",
    },
    {
        text = "Buffers",
        picker = "buffers",
    },
    -- cliphist
    -- colorscheme
    {
        text = "Command History",
        picker = "command_history",
    },
    {
        text = "Commands",
        picker = "commands",
    },
    {
        text = "Diagnostics",
        picker = "diagnostics",
    },
    {
        text = "Buffer Diagnostics",
        picker = "diagnostics_buffer",
    },
    {
        text = "File Tree",
        picker = "explorer",
    },
    {
        text = "Find Files",
        picker = "files",
    },
    {
        text = "Git Operations",
        picker_opts = new_palette("Git Operations", {
            {
                text = "Git Branches",
                picker = "git_branches",
            },
            -- git diff
            -- git files
            -- git grep
            {
                text = "Git Log",
                picker = "git_log",
            },
            {
                text = "Git Log (File)",
                picker = "git_log_file",
            },
            {
                text = "Git Log (Line)",
                picker = "git_log_line",
            },
            {
                text = "Git Stash",
                picker = "git_stash",
            },
            {
                text = "Git Status",
                picker = "git_status",
            },
        }),
    },
    {
        text = "Grep",
        picker = "grep",
    },
    {
        text = "Grep word under cursor",
        picker = "grep_word",
    },
    {
        text = "neovim Help",
        picker = "help",
    },
    -- highlights
    {
        text = "Symbols",
        picker_opts = new_palette("Symbols", {
            {
                text = "All Symbols",
                picker = "icons",
                picker_opts = {
                    icon_sources = { "emoji", "gitmoji", "nerd_fonts" },
                    title = "All Symbols",
                },
            },
            {
                text = "Emoji",
                picker = "icons",
                picker_opts = {
                    format = require("nvim_config.snacks.formatters").icon_no_source,
                    icon_sources = { "emoji" },
                    title = "Emoji",
                },
            },
            {
                text = "NerdFonts",
                picker = "icons",
                picker_opts = {
                    format = require("nvim_config.snacks.formatters").icon_no_source,
                    icon_sources = { "nerd_fonts" },
                    title = "Nerd Fonts",
                },
            },
            {
                text = "Gitmoji",
                picker = "icons",
                picker_opts = {
                    format = require("nvim_config.snacks.formatters").icon_no_source,
                    icon_sources = { "gitmoji" },
                    title = "GitMoji",
                },
            },
        }),
    },
    {
        text = "Jump List",
        picker = "jumps",
    },
    {
        text = "Key Bindings",
        picker = "keymaps",
    },
    -- lazy
    -- lines
    {
        text = "Locations List",
        picker = "loclist",
    },
    -- lsp_config
    -- lsp_declarations
    -- lsp_definitions
    -- lsp_implementations
    -- lsp_references
    -- lsp_symbols
    -- lsp_type_definitions
    -- lsp_workspace_symbols
    -- man
    {
        text = "Marks",
        picker = "marks",
    },
    {
        text = "Notifications",
        picker = "notifications",
    },
    -- picker actions
    -- picker format
    -- picker layouts
    -- picker preview
    -- pickers
    -- projects
    {
        text = "QuickFix List",
        picker = "qflist",
    },
    -- resents
    {
        text = "Registers",
        picker = "registers",
    },
    -- resume
    -- search history
    -- select
    -- smart
    {
        text = "Spelling",
        picker = "spelling",
    },
    {
        text = "Treesitter",
        picker = "treesitter",
    },
    {
        text = "Undo Tree",
        picker = "undo",
    },
    -- zoxide
    {
        text = "Lazy",
        cmd = "Lazy",
    },
    {
        text = "Themery",
        cmd = "Themery",
    },
    -- lua snip
    -- messages
})

return M
