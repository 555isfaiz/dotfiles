return {
    {
        "rcasia/neotest-java",
        lazy = true,
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",           -- for the debugger
            "rcarriga/nvim-dap-ui",            -- recommended
            "theHamsta/nvim-dap-virtual-text", -- recommended
        },
    },
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    -- require("neotest-python")({
                    --   dap = { justMyCode = false },
                    -- }),
                    -- require("neotest-plenary"),
                    -- require("neotest-vim-test")({
                    --   ignore_file_types = { "python", "vim", "lua" },
                    -- }),
                    require("neotest-java")({
                        -- config here
                        -- incremental_build = true
                    }),
                },
            })
        end
    },
}
