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
            require('which-key').add({
                icon = { icon = "󰅍 ", color = "blue" },
                plugin = "registers",
                { '<space>rg', mode = { "n", "x" }, desc = "registers" },
            })
        end
    }, -- Key Suggestions
}
