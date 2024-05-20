vim.opt.termguicolors = true

-- numbering
vim.opt.nu = true -- number
vim.opt.rnu = true -- relative line number

-- indentation
vim.opt.ts = 4 -- tab stop
vim.opt.sw = 4 -- shift width
vim.opt.et = true -- expand tab
vim.opt.ai = true -- auto indent

vim.opt.wrap = false -- no text wrap

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
