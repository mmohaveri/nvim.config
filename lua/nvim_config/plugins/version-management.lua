return {
    {
        "debugloop/telescope-undo.nvim",
        event = {
            "InsertEnter",
        },
        dependencies = {
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("telescope").load_extension("undo")
            require("telescope._extensions.picker_list.main").register("undo")
        end,
    },
}
