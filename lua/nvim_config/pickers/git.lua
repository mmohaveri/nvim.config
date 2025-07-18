return {
    title = "Git Operations",
    layout = "vscode",
    items = {
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
