-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
   "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
local theme = require("plugins.theme")
local syntax_highlighting = require("plugins.syntax-highlighting")
local file_explorer = require("plugins.file-explorer")
local editor = require("plugins.editor")
local completion = require("plugins.completion")
local miscs = require("plugins.misc")

require("lazy").setup({
    theme.plugin_spec,
    syntax_highlighting.plugin_spec,
    file_explorer.plugin_spec,
    editor.plugin_spec,
    completion.plugin_spec,
    miscs.plugin_spec,
})

editor.activate()
completion.activate()

