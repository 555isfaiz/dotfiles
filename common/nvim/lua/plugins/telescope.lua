return {
    'nvim-telescope/telescope-dap.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--no-heading',
                        -- '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        -- '--hidden',
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true
                    }
                }
            }
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dap')
        end
    }
}
