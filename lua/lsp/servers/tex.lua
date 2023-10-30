local Module = {}

local util = require("utils.lsp")

local texlab_build_status = vim.tbl_add_reverse_lookup {
  Success = 0,
  Error = 1,
  Failure = 2,
  Cancelled = 3,
}

local texlab_forward_status = vim.tbl_add_reverse_lookup {
  Success = 0,
  Error = 1,
  Failure = 2,
  Unconfigured = 3,
}

local function buf_build(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, 'texlab')
  local pos = vim.api.nvim_win_get_cursor(0)
  local params = {
    textDocument = { uri = vim.uri_from_bufnr(bufnr) },
    position = { line = pos[1] - 1, character = pos[2] },
  }
  if texlab_client then
    texlab_client.request('textDocument/build', params, function(err, result)
      if err then
        error(tostring(err))
      end
      print('Build ' .. texlab_build_status[result.status])
    end, bufnr)
  else
    print 'method textDocument/build is not supported by any servers active on the current buffer'
  end
end

local function buf_search(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, 'texlab')
  local pos = vim.api.nvim_win_get_cursor(0)
  local params = {
    textDocument = { uri = vim.uri_from_bufnr(bufnr) },
    position = { line = pos[1] - 1, character = pos[2] },
  }
  if texlab_client then
    texlab_client.request('textDocument/forwardSearch', params, function(err, result)
      if err then
        error(tostring(err))
      end
      print('Search ' .. texlab_forward_status[result.status])
    end, bufnr)
  else
    print 'method textDocument/forwardSearch is not supported by any servers active on the current buffer'
  end
end

Module.filetypes = {
    "bib",
    "plaintex",
    "tex",
}

Module.root_indicators = {
    ".git",
    ".latexmkrc"
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
                executable = 'latexmk',
                args = { '-xelatex', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = false,
                forwardSearchAfter = false,
            },
            auxDirectory = '.',
            forwardSearch = {
                executable = nil,
                args = {},
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 120,
        },
    },
    commands = {
        TexlabBuild = {
            function()
                buf_build(0)
            end,
            description = 'Build the current buffer',
        },
        TexlabForward = {
            function()
                buf_search(0)
            end,
            description = 'Forward search from current position',
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
