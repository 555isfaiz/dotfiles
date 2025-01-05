return {
    {
        'folke/which-key.nvim',
        dependencies = {
            'echasnovski/mini.icons',
        },
        config = function()
            require('which-key').setup {
                win = {
                    border = "none",
                    -- margin = { 1, 1, 1, 1 }
                },
                triggers = {
                    { "<auto>", mode = "nixsotc" },
                    { "f",      mode = { "n", "v" } },
                },
            }
        end
    }, -- Key Suggestions
}
