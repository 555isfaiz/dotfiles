return {
    {
        'echasnovski/mini.surround',
        version = false,
        event = "VeryLazy",
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = '<space>sa',            -- Add surrounding in Normal and Visual modes
                    delete = '<space>sd',         -- Delete surrounding
                    find = '<space>sf',           -- Find surrounding (to the right)
                    find_left = '<space>sF',      -- Find surrounding (to the left)
                    highlight = '<space>sh',      -- Highlight surrounding
                    replace = '<space>sr',        -- Replace surrounding
                    update_n_lines = '<space>sn', -- Update `n_lines`

                    suffix_last = 'l',            -- Suffix to search with "prev" method
                    suffix_next = 'n',            -- Suffix to search with "next" method
                },
            })
        end,
    }
}
