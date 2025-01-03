lua << END

require("which-key").add({
    {"<space>dff", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: diff file last commit"},
    {"<space>dfc", "<cmd>DiffviewOpen<cr>", desc = "Diffview: show all uncommitted changes"},
})

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

END
