local Module = {}

Module.path_separator = ":"

local function is_fs_root(path) return path == "/" end

function Module.exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
end

function Module.escape_wildcards(path) return path:gsub("([%[%]%?%*])", "\\%1") end

function Module.is_dir(filename) return Module.exists(filename) == "directory" end

function Module.is_file(filename) return Module.exists(filename) == "file" end

function Module.join(...) return table.concat(vim.tbl_flatten({ ... }), "/") end

function Module.is_absolute(filename) return filename:match("^/") end

function Module.dirname(path)
    local strip_dir_pat = "/([^/]+)$"
    local strip_sep_pat = "/$"
    if not path or #path == 0 then return end
    local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
    if #result == 0 then return "/" end
    return result
end

function Module.traverse_parents(path, callback)
    path = vim.loop.fs_realpath(path)
    local dir = path
    -- Just in case our algo is buggy, don't infinite loop.
    for _ = 1, 100 do
        dir = Module.dirname(dir)
        if not dir then return end

        -- If we can't ascend further, then stop looking.
        if callback(dir, path) then return dir, path end

        if is_fs_root(dir) then break end
    end
end

function Module.iterate_parents(path)
    local function it(_, v)
        if v and not is_fs_root(v) then
            v = Module.dirname(v)
        else
            return
        end
        if v and vim.loop.fs_realpath(v) then
            return v, path
        else
            return
        end
    end
    return it, path, path
end

function Module.is_descendant(root, path)
    if not path then return false end

    local function callback(dir, _) return dir == root end

    local dir, _ = Module.traverse_parents(path, callback)

    return dir == root
end

function Module.search_ancestors(start_path, callback)
    vim.validate({ func = { callback, "f" } })
    if callback(start_path) then return start_path end

    local guard = 100
    for path in Module.iterate_parents(start_path) do
        -- Prevent infinite recursion if our algorithm breaks
        guard = guard - 1
        if guard == 0 then return end

        if callback(path) then return path end
    end
end

function Module.find_directory_in_ancestor(start_path, dir_name)
    return Module.search_ancestors(start_path, function(path)
        if Module.is_dir(Module.join(path, dir_name)) then return path end
    end)
end

function Module.binary_exists(binary) return vim.fn.executable(binary) == 1 end

return Module
