local markdownlint_spec = require("lint.linters.markdownlint")

markdownlint_spec.cmd = "npm"

local new_args = {
    "exec",
    "--silent",
    "--yes",
    "--package=markdownlint-cli",
    "--",
    "markdownlint",
}
vim.list_extend(new_args, markdownlint_spec.args)
markdownlint_spec.args = new_args

return markdownlint_spec
