local Module = {}

local utils = require("utils")

Module.filetypes = {
    'vue',
    'typescript',
    'javascript',
    'javascriptreact',
    'typescriptreact',
    'json',
}

Module.root_indicators = {
    "package.json",
    ".git",
}

local function get_global_typescript_lib_path()
    -- Don't forget that vim.fn.system's output has a \n at the end of it!
    local node_path = vim.fn.system("source $HOME/.nvm/nvm.sh && nvm which current"):sub(1, -2)
    local ts_lib_path = string.gsub(node_path, "/bin/node", "/lib/node_modules/typescript/lib")
    return ts_lib_path
end

local function get_typescript_lib_path(root_dir)
    local global_ts = get_global_typescript_lib_path()

    local local_ts = ""
    local function check_dir(path)
        local_ts = utils.path.join(path, "node_modules", "typescript", "lib")
        return utils.path.exists(local_ts)
    end

    if utils.path.search_ancestors(root_dir, check_dir) then
        return local_ts
    else
        return global_ts
    end
end


function Module.should_skip()
    return not utils.lsp.is_part_of_vue_project(vim.api.nvim_buf_get_name(0))
end

Module.config = {
    name = "vue-language-server",
    cmd = {
        "vue-language-server",
        "--stdio",
    },
    init_options = {
        typescript = {
            -- This only works correctly iff you open the neovim from the project's directory.
            tsdk = get_typescript_lib_path(vim.api.nvim_buf_get_name(0))
        },
    },
    on_new_config = function (new_config, new_root_dir)
        if new_config.init_options and new_config.init_options.typescript and new_config.init_options.typescript.tsdk == '' then
            new_config.init_options.typescript.tsdk = get_typescript_lib_path(new_root_dir)
        end
    end
}

Module.description = [[
Provides language server support for Vue files (Vue 3),
Uses [volar](https://github.com/vuejs/language-tools) which can be installed via npm:
```sh
npm i -g @vue/language-server
```

for Vue 2 use `vscode-vue` package from `vuejs/language-tools`.
]]

return Module
