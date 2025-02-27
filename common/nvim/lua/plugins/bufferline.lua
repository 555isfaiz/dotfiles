return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        event = 'VeryLazy',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup {
                options = {
                    indicator = {
                        -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                        style = 'underline',
                    },
                    separator_style = "slant",
                    numbers = "both",
                    move_wraps_at_ends = true,
                    diagnostics = "nvim_lsp",
                    max_name_length = 25,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { 'close' }
                    },
                }
            }
        end
    },
}
