local FastLiveGrep = {}

function FastLiveGrep.word_under_cursor()
    local telescope_builtin = require("telescope.builtin")
    local word_under_cursor = vim.fn.expand("<cword>")
    telescope_builtin.live_grep({ default_text = word_under_cursor })
end

return FastLiveGrep
