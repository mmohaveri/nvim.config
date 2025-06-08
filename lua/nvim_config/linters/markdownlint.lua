local efm = "stdin:%l:%c %m,stdin:%l %m"
return {
    cmd = "npm",
    stdin = true,
    args = {
        "exec",
        "--silent",
        "--yes",
        "--package=markdownlint-cli",
        "--",
        "markdownlint",
        "--stdin",
    },
    ignore_exitcode = true,
    stream = "stderr",
    parser = require("lint.parser").from_errorformat(efm, {
        source = "markdownlint",
        severity = vim.diagnostic.severity.WARN,
    }),
}
