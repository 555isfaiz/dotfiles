return {
    'nvim-telescope/telescope-dap.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'gbrlsnchs/telescope-lsp-handlers.nvim',
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
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = { width = 0.7 }
                        -- other layout configuration here
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        },

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    },
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
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension('lsp_handlers')
        end
    }
}
