local eslint_spec = require("lint.linters.eslint")

eslint_spec.cmd = "npm"

local new_args = {
    "exec",
    "--silent",
    "--yes",
    "--",
    "eslint",
}
vim.list_extend(new_args, eslint_spec.args)
eslint_spec.args = new_args

return eslint_spec
