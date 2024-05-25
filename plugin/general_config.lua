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

-- StatusLine
vim.o.laststatus = 3

-- Fold config
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
