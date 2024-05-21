local Module = {}

local util = require("lsp_config.utils.lsp")

local texlab_build_status = vim.tbl_add_reverse_lookup({
    Success = 0,
    Error = 1,
    Failure = 2,
    Cancelled = 3,
})

local texlab_forward_status = vim.tbl_add_reverse_lookup({
    Success = 0,
    Error = 1,
    Failure = 2,
    Unconfigured = 3,
})

---@param bufnr integer
local function get_params_for_texlab_lsp(bufnr)
    local pos = vim.api.nvim_win_get_cursor(0)
    local params = {
        textDocument = {
            uri = vim.uri_from_bufnr(bufnr),
        },
        position = {
            line = pos[1] - 1,
            character = pos[2],
        },
    }

    return params
end

---@param status_table table<integer, string>
---@param operation_title string
local function get_async_response_handler(status_table, operation_title)
    local function handler(err, result)
        if err == nil then
            vim.notify(operation_title .. " " .. status_table[result.status], vim.log.levels.INFO)
            return
        end

        vim.notify(tostring(err), vim.log.levels.ERROR)
    end

    return handler
end

---@param bufnr integer
local function buf_build(bufnr)
    vim.notify("Building using TexLab ...", vim.log.levels.INFO)
    bufnr = util.validate_bufnr(bufnr)
    local texlab_lsp_client = util.get_active_client_by_name(bufnr, Module.config.name)

    if texlab_lsp_client == nil then return end

    texlab_lsp_client.request(
        "textDocument/build",
        get_params_for_texlab_lsp(bufnr),
        get_async_response_handler(texlab_build_status, "Build"),
        bufnr
    )
end

local function buf_search(bufnr)
    vim.notify("Searching using TexLab ...", vim.log.levels.INFO)
    bufnr = util.validate_bufnr(bufnr)
    local texlab_lsp_client = util.get_active_client_by_name(bufnr, Module.config.name)

    if texlab_lsp_client == nil then return end

    texlab_lsp_client.request(
        "textDocument/forwardSearch",
        get_params_for_texlab_lsp(bufnr),
        get_async_response_handler(texlab_forward_status, "Search"),
        bufnr
    )
end

Module.filetypes = {
    "bib",
    "plaintex",
    "tex",
}

Module.root_indicators = {
    ".git",
    ".latexmkrc",
}

Module.config = {
    name = "tex-language-server",
    cmd = {
        "texlab",
    },
    single_file_support = true,
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = "latexmk",
                args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = false,
                forwardSearchAfter = false,
            },
            auxDirectory = ".",
            forwardSearch = {
                executable = nil,
                args = {},
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = "latexindent",
            latexindent = {
                ["local"] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = "texlab",
            formatterLineLength = 120,
        },
    },
    commands = {
        TexlabBuild = {
            function() buf_build(0) end,
            description = "Build the current buffer",
        },
        TexlabForward = {
            function() buf_search(0) end,
            description = "Forward search from current position",
        },
    },
}

Module.description = [[
Provides language server support for TEX files.
Uses [TexLab](https://github.com/latex-lsp/texlab).
which can installed from its github page.

It also relies on latexindent, chktex, and latexmk all of
which are a part of the `texlive-full` package on debian.
]]

return Module
