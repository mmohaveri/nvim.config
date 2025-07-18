return {
    title = "Command Palette",
    layout = "vscode",
    items = {
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
            picker = "git_operations",
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
    },

    format = function(item) return { { item.text } } end,
    confirm = function(picker, item)
        picker:close()

        if item then
            if item.picker then
                require("snacks").picker[item.picker]()
            elseif item.callback then
                item.callback()
            elseif item.cmd then
                vim.cmd[item.cmd]()
            else
                vim.notify("No picker, callback, or cmd defined for '" .. item.text .. "'", vim.log.levels.ERROR)
            end
        end
    end,
    matcher = {
        fuzzy = true,
        smartcase = true,
        sort_empty = false,
    },
}
