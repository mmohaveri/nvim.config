return {
    "awk",
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "corn",
    "cpp",
    "css",
    "csv",
    "desktop",
    "devicetree",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "gpg",
    "graphql",
    "hcl",
    "helm",
    "html",
    "htmldjango",
    "http",
    "ini",
    "ini",
    "javascript",
    "jinja",
    "jinja_inline",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "jsonnet",
    "kotlin",
    "latex",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "mermaid",
    "ninja",
    "nix",
    "nu",
    "passwd",
    "passwd",
    "pem",
    "proto",
    "python",
    "query",
    "readline",
    "regex",
    "requirements",
    "rust",
    "scss",
    "sql",
    "ssh_config",
    "ssh_config",
    "terraform",
    "toml",
    "tsv",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
}

-- return {
--     {
--         "nvim-treesitter/nvim-treesitter",
--         branch = "master",
--         event = {
--             "VeryLazy",
--         },
--         lazy = vim.fn.argc(-1) == 0,
--         build = ":TSUpdate",
--         main = "nvim-treesitter.configs",
--         opts = {
--             ensure_installed = parsers,
--             ignore_install = {},
--             auto_install = true,
--             sync_install = true,
--             highlight = {
--                 enable = true,
--                 disable = {},
--                 additional_vim_regex_highlighting = {},
--             },
--             incremental_selection = {
--                 enable = false,
--             },
--             indent = {
--                 enable = true,
--                 disable = {},
--             },
--         },
--     },
--     {
--         "nvim-treesitter/nvim-treesitter-context",
--         config = true,
--         cmd = { "TSContext" },
--         dependencies = {
--             "nvim-treesitter/nvim-treesitter",
--         },
--     },
--     {
--         "JoosepAlviste/nvim-ts-context-commentstring",
--         dependencies = {
--             "nvim-treesitter/nvim-treesitter",
--         },
--         opts = {
--             enable_autocmd = false,
--         },
--         config = function(_, opts)
--             require("ts_context_commentstring").setup(opts)
--
--             local vim_original_get_option = vim.filetype.get_option
--             vim.filetype.get_option = function(filetype, option)
--                 if option == "commentstring" then
--                     return require("ts_context_commentstring.internal").calculate_commentstring()
--                 else
--                     return vim_original_get_option(filetype, option)
--                 end
--             end
--         end,
--     },
--     {
--         "kylechui/nvim-surround",
--         version = "*",
--         event = {
--             "BufReadPre",
--             "BufNewFile",
--         },
--         config = true,
--     },
--     -- {
--     --     "nvim-treesitter/nvim-treesitter-textobjects",
--     --     dependencies = {
--     --         "nvim-treesitter/nvim-treesitter",
--     --     },
--     -- },
--
-- }
