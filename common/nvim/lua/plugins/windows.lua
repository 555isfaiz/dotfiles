return {
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup({
                autowidth = {     --		       |windows.autowidth|
                    enable = true,
                    winwidth = 5, --		        |windows.winwidth|
                    filetype = {  --	      |windows.autowidth.filetype|
                        help = 2,
                    },
                },
                ignore = { --			  |windows.ignore|
                    buftype = { "quickfix", "nofile" },
                    filetype = {
                        "NvimTree",
                        "neo-tree",
                        "undotree",
                        "gundo",
                        "dapui_scopes",
                        "dapui_breakpoints",
                        "dapui_stacks",
                        "dapui_watches",
                        "dap_repl",
                        "dapui_console"
                    }
                },
                animation = {
                    enable = true,
                    duration = 100,
                    fps = 120,
                    easing = "in_out_sine"
                }
            })
        end
    },
}
