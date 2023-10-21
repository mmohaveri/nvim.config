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
local plugins = {
    require("plugins.theme"),
    require("plugins.syntax-highlighting"),
    require("plugins.file-explorer"),
    require("plugins.editor"),
    require("plugins.completion"),
    require("plugins.lint"),
    require("plugins.misc"),
}

local plugins_spec = {}

for _, p in ipairs(plugins) do
    table.insert(plugins_spec, p.plugin_spec)
end

require("lazy").setup(plugins_spec)

for _, p in ipairs(plugins) do
    pcall(p.activate)
end

