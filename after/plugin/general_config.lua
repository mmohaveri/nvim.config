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

require("nvim_config.config.fold").apply_fold_config()
require("nvim_config.config.key_bindings").set_keybindings()

require("nvim_config.utils.autosave").register_autocmd()
require("nvim_config.utils.copy_to_system_clipboard").register_user_command()
require("nvim_config.utils.lsp_notification").register_autocmd()
