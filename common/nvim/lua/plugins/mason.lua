return {
    {
        'mason-org/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = { 'williamboman/mason.nvim', 'stevearc/conform.nvim' },
    },
    {
        "rshkarin/mason-nvim-lint",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-lint" },
        config = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    require("lint").try_lint()
                end,
            })
            require('lint').linters_by_ft = {
                markdown = { 'vale' },
                sql = { 'sqlfluff' },
            }
        end
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        event = 'VeryLazy',
        config = function()
            require("mason-nvim-dap").setup()
        end
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        -- config = function()
        --     require("mason-lspconfig").setup {
        --         automatic_enable = false,
        --         -- The first entry (without a key) will be the default handler
        --         -- and will be called for each installed server that doesn't have
        --         -- a dedicated handler.
        --         function(server_name) -- default handler (optional)
        --             require("lspconfig")[server_name].setup {
        --                 capabilities = require("cmp_nvim_lsp").default_capabilities()
        --             }
        --         end,
        --         -- Next, you can provide a dedicated handler for specific servers.
        --         -- For example, a handler override for the `rust_analyzer`:
        --         -- ["pyright"] = function ()
        --         --    require("lspconfig")["pyright"].setup {
        --         --      capabilities = require("cmp_nvim_lsp").default_capabilities();
        --         --      settings = {
        --         --          python = {
        --         --            analysis = {
        --         --               typeCheckingMode = 'off'
        --         --              }
        --         --            }
        --         --        }
        --         --      }
        --         -- end,
        --         ["jdtls"] = function()
        --             -- The key is to do nothing here...
        --         end
        --     }
        -- end
    },
}
