local Module = {}

Module.filetypes = { "lua" }

Module.root_indicators = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    "selene.yaml",
    ".git",
}

Module.config = {
    name = "lua",
    cmd = {
        "lua-language-server",
        "--metapath",
        vim.fn.stdpath("cache") .. "/lua-language-server",
    },
    single_file_support = true,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            telemetry = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}

Module.description = [[
Provides language server support for Lua files.
Uses [lua-language-server](https://github.com/luals/lua-language-server)
]]

return Module
