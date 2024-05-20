vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false

-- Show a list of places it's replacing when doing an inc command, i.e: `:%`
vim.opt.inccommand = "split"

-- Ingore case only if the query is all lower case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Focus on buttom and right when splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.autochdir = false
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.autowriteall = true

vim.opt.cursorline = true
vim.hlsearch = true

-- vim.opt.sp = "en"		-- spell
-- set clipboard+=unnamed

-- WinBar
local win_bar = require("utils.winbar")
win_bar.setup()

-- StatusLine
vim.o.laststatus = 3

-- File types with word-wrap enabled:
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "markdown",
        "bib",
        "plaintex",
        "tex",
    },
    callback = function() vim.opt_local.wrap = true end,
})

-- File types with fixed text-width:
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "markdown",
        "bib",
        "plaintex",
        "tex",
    },
    callback = function() vim.opt_local.textwidth = 80 end,
})

-- File types with two space indentation:
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "markdown",
        "css",
        "scss",
        "less",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "html",
        "json",
        "toml",
        "yaml",
    },
    callback = function()
        vim.opt_local.ts = 2
        vim.opt_local.sw = 2
    end,
})
