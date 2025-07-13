local parser_git_repo = "https://github.com/matoous/tree-sitter-fga"

local M = {}

M.register_filetype = function()
    vim.filetype.add({
        extension = {
            fga = "fga",
        },
    })
end

M.register_ts_parser = function()
    require("nvim-treesitter.parsers").get_parser_configs().fga = {
        install_info = {
            url = parser_git_repo,
            files = { "src/parser.c" },
            branch = "main",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
        },
        filetype = "fga",
    }
end

M.install_ts_queries = function() require("nvim_config.treesitter.utils").install_queries("fga", parser_git_repo) end

return M
