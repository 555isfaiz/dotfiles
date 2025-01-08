return {
    'talha-akram/noctis.nvim',
    'EdenEast/nightfox.nvim',
    'rebelot/kanagawa.nvim',
    'marko-cerovac/material.nvim',
    'Shatur/neovim-ayu',
    'kvrohit/mellow.nvim', -- Color Scheme
    'jamestthompson3/nvim-remote-containers',
    'folke/tokyonight.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-neo-tree/neo-tree.nvim',
    'rcarriga/nvim-notify',  -- Notification Boxes
    'ap/vim-css-color',      -- CSS Color Preview
    'nvim-lua/plenary.nvim', -- Telescope Dependency
    'slyces/hierarchy.nvim',
    'ray-x/lsp_signature.nvim',
    'othree/html5.vim',
    { 'romgrk/barbar.nvim', event = 'VeryLazy' }, -- Tabs
    { "catppuccin/nvim",    name = "catppuccin", priority = 1000 },
    {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require 'alpha.themes.dashboard'.config)
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VeryLazy',
        config = function()
            require("ibl").setup {
                -- for example, context is off by default, use this to turn it on
                -- show_current_context = true,
                -- show_current_context_start = true,
            }
        end
    },
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
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup()
        end
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
        event = 'VeryLazy',
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
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
