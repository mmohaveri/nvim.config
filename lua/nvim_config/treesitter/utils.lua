local M = {}

local ts_custom_rtp = vim.fn.stdpath("data") .. "/treesitter_custom_parsers"

---Installs treesitter queries from a git repo
---@param lang string
---@param repo_url string
M.install_queries = function(lang, repo_url)
    local query_files = { "highlights", "injections", "indents", "folds", "locals", "textobjects" }

    local queries_dir = ts_custom_rtp .. "/queries/" .. lang
    vim.fn.mkdir(queries_dir, "p")

    local tmp_repo_dir = "/tmp/" .. lang

    local clone_cmd = string.format("git clone '%s' %s", repo_url, tmp_repo_dir)
    os.execute(clone_cmd)

    for _, query in ipairs(query_files) do
        local query_file_name = query .. ".scm"
        local source = tmp_repo_dir .. "/queries/" .. query_file_name
        local dest = queries_dir .. "/" .. query_file_name

        vim.fn.rename(source, dest)
    end

    vim.fn.delete(tmp_repo_dir, "rf")
end

M.register_ts_runtime_path = function() vim.opt.runtimepath:prepend(ts_custom_rtp) end

return M
