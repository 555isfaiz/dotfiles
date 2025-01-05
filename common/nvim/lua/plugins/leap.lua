return {
    {
        'ggandor/flit.nvim',
        config = function()
            require('flit').setup {
                keys = { f = 't', F = 'T', t = 'r', T = 'R' },
                -- A string like "nv", "nvo", "o", etc.
                labeled_modes = "v",
                multiline = true,
                -- Like `leap`s similar argument (call-specific overrides).
                -- E.g.: opts = { equivalence_classes = {} }
                opts = {}
            }
        end
    },
    {
        'ggandor/leap.nvim',
        config = function()
            vim.api.nvim_create_autocmd('ColorScheme', {
                callback = function()
                    -- if vim.g.colors_name == "noctis_bordo" then
                    -- Force using the defaults of Leap:
                    require('leap').init_highlight(true)
                    -- And/or make your own tweaks:
                    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
                    vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { link = 'Normal' })
                    vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { link = 'Substitute' })
                    vim.api.nvim_set_hl(0, 'LeapMatch', { link = 'ErrorMsg' })
                    -- etc.
                    -- end
                end
            })
        end
    },
}
