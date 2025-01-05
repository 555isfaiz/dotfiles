return {
    'talha-akram/noctis.nvim',
    'EdenEast/nightfox.nvim',
    'rebelot/kanagawa.nvim',
    'marko-cerovac/material.nvim',
    'Shatur/neovim-ayu',
    {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require 'alpha.themes.dashboard'.config)
        end
    },
    { "catppuccin/nvim",              name = "catppuccin",             priority = 1000 },
    'kvrohit/mellow.nvim', -- Color Scheme
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup {
                -- for example, context is off by default, use this to turn it on
                -- show_current_context = true,
                -- show_current_context_start = true,
            }
        end
    },
    'tpope/vim-repeat',
    'jamestthompson3/nvim-remote-containers',
    'folke/tokyonight.nvim',
    'romgrk/barbar.nvim', -- Tabs
    'MunifTanjim/nui.nvim',
    'nvim-neo-tree/neo-tree.nvim',
    'rcarriga/nvim-notify',                                               -- Notification Boxes
    {
        'xiyaowong/nvim-transparent',
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {},   -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },
    --  'wakatime/vim-wakatime' -- Time Logging
    'ap/vim-css-color',       -- CSS Color Preview
    'ryanoasis/vim-devicons', -- Developer Icons
    'nvim-lua/plenary.nvim',  -- Telescope Dependency
    --  'sbdchd/neoformat' -- Auto formatter
    {
        'folke/neodev.nvim',
        config = function()
            require("neodev").setup({})
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'slyces/hierarchy.nvim',
    'lewis6991/hover.nvim',
    'ray-x/lsp_signature.nvim',
    -- 'airblade/vim-gitgutter',

    -- Extra Syntax Highlighting
    'othree/html5.vim',
    'pangloss/vim-javascript',
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = "java",
        dependencies = {
            'mfussenegger/nvim-dap',
        }
    },
    {
        "tiagovla/tokyodark.nvim",
        opts = {},
        config = function(_, opts)
            require("tokyodark").setup(opts) -- calling setup is optional
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        lazy = true,
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
            require("trouble").setup {}
        end
    },
}
