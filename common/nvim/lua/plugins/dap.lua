return {
    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        config = function()
            require("dapui").setup()
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = "py",
        config = function()
            require('dap-python').setup('~/.pyvenv/bin/python')
        end
    },
    {
        'LiadOz/nvim-dap-repl-highlights',
        event = "VeryLazy",
        config = function()
            require('nvim-dap-repl-highlights').setup()
        end
    },
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        dependencies = {
            'jay-babu/mason-nvim-dap.nvim',
        },
        config = function()
            if vim.fn.has('macunix') == 1 then
                require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'c', 'cpp' } })
            else
                require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
            end

            local dap = require('dap')
            local home_dir = os.getenv('HOME')

            vim.fn.sign_define('DapBreakpoint',
                { text = '', texthl = 'ErrorMsg', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition',
                { text = '', texthl = 'ErrorMsg', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapStopped', { text = '→', texthl = 'ErrorMsg', linehl = 'DiffText', numhl = 'DiffText' })

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = home_dir ..
                    '/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }
            dap.adapters.lldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    -- CHANGE THIS to your path!
                    command = home_dir .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                }
            }

            local api = vim.api
            local keymap_restore = {}
            dap.listeners.after['event_initialized']['me'] = function()
                for _, buf in pairs(api.nvim_list_bufs()) do
                    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
                    for _, keymap in pairs(keymaps) do
                        if keymap.lhs == "I" then
                            table.insert(keymap_restore, keymap)
                            api.nvim_buf_del_keymap(buf, 'n', 'I')
                        end
                    end
                end
                api.nvim_set_keymap(
                    'n', 'I', '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
                    { desc = "DAP: show hover variable info", silent = true })
            end

            dap.listeners.after['event_terminated']['me'] = function()
                for _, keymap in pairs(keymap_restore) do
                    api.nvim_buf_set_keymap(
                        keymap.buffer,
                        keymap.mode,
                        keymap.lhs,
                        keymap.rhs,
                        { silent = keymap.silent == 1 }
                    )
                end
                keymap_restore = {}
            end
        end
    }
}
