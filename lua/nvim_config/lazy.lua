local lazy_root = vim.fn.stdpath("data") .. "/lazy"
local lazy_path = lazy_root .. "/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_path,
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim into `" .. lazy_path .. "`:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit...", "Normal" },
        }, true, {})

        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.runtimepath:prepend(lazy_path)

require("lazy").setup("nvim_config.plugins", {
    root = lazy_root,
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
    defaults = {
        lazy = true,
    },
    local_spec = true,
    install = {
        missing = true,
    },
    checker = {
        enabled = true,
        notify = true,
        frequency = 60 * 60 * 24, -- check for updates every day
        check_pinned = false,
    },
    change_detection = {
        enabled = true,
        notify = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
    profiling = {
        loader = false,
        require = false,
    },
    dev = {
        path = "~/Documents/Personal/Projects",
        patterns = { "mmohaveri" },
        fallback = true,
    },

    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json",
    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        backdrop = 60,
        title = "    lazy.nvim    ",
        title_pos = "center",
    },
})
