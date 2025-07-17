local yamllint_spec = require("lint.linters.yamllint")

yamllint_spec.cmd = "uv"

local new_args = {
    "run",
    "--with",
    "yamllint",
    "yamllint",
}
vim.list_extend(new_args, yamllint_spec.args)
yamllint_spec.args = new_args

return yamllint_spec
