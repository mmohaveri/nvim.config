local cspell_spec = require("lint.linters.cspell")

cspell_spec.cmd = "npm"

local new_args = {
    "exec",
    "--silent",
    "--yes",
    "--",
    "cspell",
}
vim.list_extend(new_args, cspell_spec.args)
cspell_spec.args = new_args

return cspell_spec
