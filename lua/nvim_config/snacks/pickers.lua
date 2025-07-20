---@class snacks.picker.Palette
---@field [string] snacks.picker.Palette.Config
local M = {}

---@param palette_name string
---@param items snacks.picker.PaletteItem[]
---@return snacks.picker.Palette.Config
local function new_palette(palette_name, items)
    local searching = false
    local ref ---@type snacks.Picker.ref

    ---@type snacks.picker.Palette.Config
    return {
        title = palette_name,
        finder = require("nvim_config.snacks.finders").palette_items,
        format = require("nvim_config.snacks.formatters").palette_item,
        layout = { preset = "vscode" },
        confirm = require("nvim_config.snacks.actions").palette_item,
        filter = {
            --- Trigger finder when pattern toggles between empty / non-empty
            ---@param picker snacks.Picker
            ---@param filter snacks.picker.Filter
            transform = function(picker, filter)
                ref = picker:ref()
                local s = not filter:is_empty()
                if searching ~= s then
                    searching = s
                    filter.meta.searching = searching
                    return true
                end
            end,
        },
        matcher = {
            fuzzy = true,
            smartcase = true,
            sort_empty = false,
            --- Add parent items to matching children (similar to explorer)
            ---@param matcher snacks.picker.Matcher
            ---@param item snacks.picker.PaletteItem
            on_match = function(matcher, item)
                if not searching then return end
                local picker = ref.value
                if picker and item.score > 0 then
                    local parent = item.parent
                    while parent do
                        if parent.score == 0 or parent.match_tick ~= matcher.tick then
                            -- Add parent with same score as child initially, we'll rebalance in on_done
                            parent.score = item.score
                            parent.match_tick = matcher.tick
                            parent.match_topk = nil
                            picker.list:add(parent)
                        else
                            break -- Critical: stop when parent already processed
                        end
                        parent = parent.parent
                    end
                end
            end,
            on_done = function()
                if not searching then return end
                local picker = ref.value
                if not picker or picker.closed then return end

                -- Deduplicate items based on text content
                local seen = {}
                local unique_items = {}

                for item in picker:iter() do
                    local key = item.text
                    if not seen[key] then
                        seen[key] = true
                        table.insert(unique_items, item)
                    end
                end

                -- Rebalance scores to ensure parents appear right before their children
                local function rebalance_scores()
                    -- Group items by parent
                    local parent_groups = {}
                    local standalone_items = {}

                    for _, item in ipairs(unique_items) do
                        if item.parent then
                            local parent_text = item.parent.text
                            if not parent_groups[parent_text] then
                                parent_groups[parent_text] = { parent = nil, children = {} }
                            end
                            table.insert(parent_groups[parent_text].children, item)
                        else
                            table.insert(standalone_items, item)
                            -- Check if this item is a parent
                            for _, other_item in ipairs(unique_items) do
                                if other_item.parent and other_item.parent.text == item.text then
                                    parent_groups[item.text] = parent_groups[item.text]
                                        or { parent = nil, children = {} }
                                    parent_groups[item.text].parent = item
                                    break
                                end
                            end
                        end
                    end

                    -- For each parent group, rebalance scores
                    for parent_text, group in pairs(parent_groups) do
                        if group.parent and #group.children > 0 then
                            -- Find min and max scores of children
                            local min_child_score = math.huge
                            local max_child_score = -math.huge
                            for _, child in ipairs(group.children) do
                                min_child_score = math.min(min_child_score, child.score)
                                max_child_score = math.max(max_child_score, child.score)
                            end

                            -- Find standalone items that fall in the range [min_child_score, max_child_score]
                            local conflicting_items = {}
                            for _, item in ipairs(standalone_items) do
                                if
                                    item.score >= min_child_score
                                    and item.score <= max_child_score
                                    and item ~= group.parent
                                then
                                    table.insert(conflicting_items, item)
                                end
                            end

                            -- If there are conflicts, adjust children scores to be higher than conflicting items
                            if #conflicting_items > 0 then
                                local max_conflict_score = -math.huge
                                for _, item in ipairs(conflicting_items) do
                                    max_conflict_score = math.max(max_conflict_score, item.score)
                                end

                                -- Adjust children scores to be above conflicts while preserving order
                                table.sort(group.children, function(a, b) return a.score > b.score end)
                                local score_increment = 0.01
                                for i, child in ipairs(group.children) do
                                    child.score = max_conflict_score + score_increment * i
                                end

                                -- Set parent score to be just above highest child
                                group.parent.score = max_conflict_score + score_increment * #group.children + 0.01
                            else
                                -- No conflicts, just ensure parent is above highest child
                                group.parent.score = max_child_score + 0.01
                            end
                        end
                    end
                end

                rebalance_scores()

                -- Rebuild the list with deduplicated and rebalanced items
                picker.list:clear()
                for _, item in ipairs(unique_items) do
                    picker.list:add(item)
                end
            end,
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
