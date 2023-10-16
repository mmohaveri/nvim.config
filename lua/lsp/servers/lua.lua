local Module = {}

Module.pattern = "lua"
Module.root_indicators = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
}

Module.config = {
    name = "lua",
    cmd = {
        "lua-language-server",
        "--metapath",
        vim.fn.stdpath("cache") .. "/lua-language-server",
    },
    filetypes = { 'lua' },
    single_file_support = true,
    settings = {
        Lua = {
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

return Module
