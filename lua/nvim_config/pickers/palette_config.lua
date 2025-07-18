---@class snacks.picker.Palette
---@field [string] snacks.picker.Palette.Config
local M = {}

local palette_picker = require("nvim_config.pickers.palette")

M.command_palette = palette_picker.new("Command Palette", {
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
        picker = "git",
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
        text = "Emoji, Glyph, Symbols",
        picker = "icons",
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

M.git = palette_picker.new("Git Commands", {
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
})

return M
