return {
    {
        'cshuaimin/ssr.nvim',
        event = "VeryLazy",
        config = function()
            require("ssr").setup {
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<space><cr>",
                },
            }
        end
    }
}
