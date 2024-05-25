local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("emoji")
telescope.load_extension("glyph")
telescope.load_extension("notify")
telescope.load_extension("toggleterm_manager")
telescope.load_extension("live_grep_args")

-- picker_list must be the last one
telescope.load_extension("picker_list")
