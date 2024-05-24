local kind_icons = {
    Text = "󰊄",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰫧",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "󰌆",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "󰉺",
}

return {
    {
        "hrsh7th/nvim-cmp",
        event = {
            "InsertEnter",
            "CmdlineEnter",
        },
        dependencies = {
            {
                "benfowler/telescope-luasnip.nvim",
                dependencies = {
                    "nvim-tree/nvim-tree.lua",
                    {
                        "L3MON4D3/LuaSnip",
                        version = "v2.*",
                        build = "make install_jsregexp",
                        dependencies = {
                            "rafamadriz/friendly-snippets",
                        },
                        config = function()
                            require("luasnip").setup({})
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
                module = "telescope._extensions.luasnip",
                config = function()
                    require("telescope").load_extension("luasnip")
                    require("telescope._extensions.picker_list.main").register("luasnip")
                end,
            },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")

            local cmp_config = {
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-n>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- replace native vim autocomplete with cmp
                    ["<C-y>"] = cmp.config.disable, -- remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            luasnip = "[Snippet]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                view = {
                    entries = {
                        native_menu = true,
                    },
                },
                experimental = {
                    ghost_text = true,
                },
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
            }

            cmp.setup(cmp_config)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = {
                    "BufReadPre",
                    "BufNewFile",
                },
                config = true,
            },
        },
        opts = function()
            return {
                toggler = {
                    line = "tcl",
                    block = "tcb",
                },
                opleader = {
                    line = "tcl",
                    block = "tcb",
                },
                mappings = {
                    basic = true,
                    extra = false,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },
}

-- cmp.setup.cmdline(":", {
--    mapping = cmp.mapping.preset.cmdline(),
--      sources = cmp.config.sources(
--        {
--            { name = 'path' }
--        },
--        {
--            { name = 'cmdline' }
--        }
--    )
-- })
