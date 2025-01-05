return {
    {
        'sindrets/diffview.nvim',
        event = "VeryLazy",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "DiffviewFiles",
                    "DiffviewFileHistory"
                },
                command = [[
                    nnoremap <buffer><silent> <Esc> :DiffviewClose<CR>
                    set nobuflisted
                ]],
            })

            require("diffview").setup({
                file_panel = {
                    win_config = {
                        position = "bottom",
                        height = 16
                    }
                }
            })
        end
    },
}
