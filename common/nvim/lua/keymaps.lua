local gs = package.loaded.gitsigns

function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

require("which-key").add({
    ------------
    --  Misc  --
    ------------
    { "<Tab>",      ":>1<CR>",                       desc = "Indent line" },
    { "<Tab>",      ":'<,'>1><CR>gv",                desc = "Indent selection",               mode = "v" },
    { "<C-m>",      ":WindowsMaximize<CR>",          desc = "Maximize window" },
    { "S",          "v<space>u",                     desc = "Select a treesitter node" },
    { "S",          "<space>u",                      desc = "Increment treesitter selection", mode = "v" },
    { "<M-k>",      ":m .-2<CR>==",                  desc = "Move line up" },
    { "<M-j>",      ":m .+1<CR>==",                  desc = "Move line down" },
    { "<M-k>",      ":m '<-2<CR>gv=gv",              desc = "Move selected line up",          mode = "v" },
    { "<M-j>",      ":m '>+1<CR>gv=gv",              desc = "Move selected line down",        mode = "v" },
    { "<Esc><Esc>", "<C-\\><Cn>",                    desc = "Exit terminal mode",             mode = "t" },
    { "<A-h>",      "<C-O>",                         desc = "Go back" },
    { "<A-l>",      "<C-I>",                         desc = "Go forward" },
    { "'",          "<C-W>",                         desc = "Window prefix" },
    { "<C-l>",      "$",                             desc = "Go to line end",                 mode = { 'n', 'v' } },
    { "<C-h>",      "^",                             desc = "Go to line start",               mode = { 'n', 'v' } },

    ------------
    -- Barbar --
    ------------
    { "<A-<>",      "<Cmd>BufferMovePrevious<CR>",   desc = "Barbar: buffer move previous" },
    { "<A->>",      "<Cmd>BufferMoveNext<CR>",       desc = "Barbar: buffer move next" },

    { "Q",          "<Cmd>BufferPrevious<CR>",       desc = "Barbar: buffer previous" },
    { "W",          "<Cmd>BufferNext<CR>",           desc = "Barbar: buffer next" },

    { "<C-q>",      "<Cmd>BufferClose<CR>",          desc = "Barbar: buffer close" },

    { "<A-1>",      "<Cmd>BufferGoto 1<CR>",         desc = "Barbar: go to buffer 1" },
    { "<A-2>",      "<Cmd>BufferGoto 2<CR>",         desc = "Barbar: go to buffer 2" },
    { "<A-3>",      "<Cmd>BufferGoto 3<CR>",         desc = "Barbar: go to buffer 3" },
    { "<A-4>",      "<Cmd>BufferGoto 4<CR>",         desc = "Barbar: go to buffer 4" },
    { "<A-5>",      "<Cmd>BufferGoto 5<CR>",         desc = "Barbar: go to buffer 5" },
    { "<A-6>",      "<Cmd>BufferGoto 6<CR>",         desc = "Barbar: go to buffer 6" },
    { "<A-7>",      "<Cmd>BufferGoto 7<CR>",         desc = "Barbar: go to buffer 7" },
    { "<A-8>",      "<Cmd>BufferGoto 8<CR>",         desc = "Barbar: go to buffer 8" },
    { "<A-9>",      "<Cmd>BufferGoto 9<CR>",         desc = "Barbar: go to buffer 9" },
    { "<A-0>",      "<Cmd>BufferLast<CR>",           desc = "Barbar: go to last buffer" },

    ---------
    -- DAP --
    ---------
    { '<F5>',       require 'dap'.continue,          desc = "DAP: start or continue" },
    { '<F6>',       require 'dap'.terminate,         desc = "DAP: terminate" },
    { '<F7>',       require 'dap'.restart,           desc = "DAP: restart" },
    { '<F10>',      require 'dap'.step_over,         desc = "DAP: step over" },
    { '<F11>',      require 'dap'.step_into,         desc = "DAP: step into" },
    { 'B',          require 'dap'.toggle_breakpoint, desc = "DAP: toggle breakpoint" },
    {
        '<Space>b',
        function()
            vim.ui.input({ prompt = 'Conditional Breakpoint: ' }, function(input)
                require 'dap'.toggle_breakpoint(input)
            end)
        end,
        desc = "DAP: toggle conditional breakpoint"
    },
    { '<F1>',       require 'dapui'.toggle,                                              desc = "DAP: toggle UI" },
    {
        "<space>ev",
        function()
            vim.ui.input({ prompt = 'Enter value for Evaluate: ', completion = 'command' }, function(input)
                require("dapui").eval(input)
            end)
        end,
        desc = "DAP: evaluate experssion"
    },

    --------------
    -- Diffview --
    --------------
    { "<space>dff", "<cmd>DiffviewFileHistory %<cr>",                                    desc = "Diffview: diff file last commit" },
    { "<space>dfc", "<cmd>DiffviewOpen<cr>",                                             desc = "Diffview: show all uncommitted changes" },

    --------------
    -- Gitsigns --
    --------------
    { '<space>hs',  gs.stage_hunk,                                                       desc = "Git hunk: stage hunk" },
    { '<space>hr',  gs.reset_hunk,                                                       desc = "Git hunk: reset hunk" },
    { '<space>hs',  function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Git hunk: stage hunk",                  mode = "v" },
    { '<space>hr',  function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Git hunk: reset hunk",                  mode = "v" },
    { '<space>hS',  gs.stage_buffer,                                                     desc = "Git hunk: stage buffer" },
    { '<space>hu',  gs.undo_stage_hunk,                                                  desc = "Git hunk: undo stage buffer" },
    { '<space>hR',  gs.reset_buffer,                                                     desc = "Git hunk: reset buffer" },
    { '<space>hp',  gs.preview_hunk,                                                     desc = "Git hunk: preview hunk" },
    { '<space>hb',  function() gs.blame_line { full = true } end,                        desc = "Git hunk: blame file" },
    { '<space>tb',  gs.toggle_current_line_blame,                                        desc = "Git hunk: blame line" },
    { '<space>hd',  gs.diffthis,                                                         desc = "Git hunk: diff hunk" },
    { '<space>hD',  function() gs.diffthis('~') end,                                     desc = "Git hunk: diff file" },
    { '<space>td',  gs.toggle_deleted,                                                   desc = "Git hunk: toggle deleted" },
    {
        '[c',
        function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end,
        desc = "Git hunk: go to previous change",
        { expr = true }
    },
    {
        ']c',
        function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end,
        desc = "Git hunk: go to next change",
        { expr = true }
    },
    { 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = "Git hunk: select hunk", mode = { 'o', 'x' } },

    --------------
    --   Hover  --
    --------------
    -- { "K",     require("hover").hover,                                   desc = "Hover: show" },
    -- { "gK",    require("hover").hover_select,                            desc = "Hover: select" },
    -- { "<C-p>", function() require("hover").hover_switch("previous") end, desc = "Hover: previous source" },
    -- { "<C-n>", function() require("hover").hover_switch("next") end,     desc = "Hover: next source" },

    --------------
    --   Leap   --
    --------------
    { 's',  '<Plug>(leap)',                   desc = "Leap: start leap",      mode = { 'n', 'x', 'o' } },
    {
        '<Space>l',
        function()
            require('leap.treesitter').select()
        end,
        desc = "Leap: start treesitter leap",
        mode = { 'n', 'x', 'o' }
    },
    { '<Space>L',  'V<cmd>lua require("leap.treesitter").select()<cr>', desc = "Leap: start linewise treesitter leap", mode = { 'n', 'x', 'o' } },

    --------------
    --   LSP    --
    --------------
    { '<A-o>',     ':ClangdSwitchSourceHeader<CR>',                     desc = "Clang: switch source header" },
    { '<space>e',  vim.diagnostic.open_float,                           desc = "LSP: open floating diagnostic" },
    { '<space>q',  vim.diagnostic.setloclist,                           desc = "LSP: diagnostic set local list" },
    { '[d',        '<cmd>Lspsaga diagnostic_jump_prev<cr>',             desc = "LSPSaga: jump to previous diagnostic" },
    { ']d',        '<cmd>Lspsaga diagnostic_jump_next<cr>',             desc = "LSPSaga: jump to next diagnostic" },
    { 'fm',        '<cmd>Lspsaga outline<cr>',                          desc = "LSPSaga: show file outline" },
    { 'gr',        '<cmd>Lspsaga finder<cr>',                           desc = "LSPSaga: find reference" },
    { 'fs',        '<cmd>Lspsaga subtypes<cr>',                         desc = "LSPSaga: show subtypes" },
    -- You probably also want to set a keymap to toggle aerial
    -- {'<F3>', '<cmd>AerialToggle!<CR>', desc = "Aerial: toggle UI"},
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    { 'gD',        vim.lsp.buf.declaration,                             desc = "LSP: go to declaration", },
    { 'K',         vim.lsp.buf.hover,                                   desc = "LSP: show hover info", },
    { 'gi',        vim.lsp.buf.implementation,                          desc = "LSP: go to implementation", },
    { '<C-k>',     vim.lsp.buf.signature_help,                          desc = "LSP: show signature help", },
    { '<space>wa', vim.lsp.buf.add_workspace_folder,                    desc = "LSP: add workspace folder", },
    { '<space>wr', vim.lsp.buf.remove_workspace_folder,                 desc = "LSP: remove workspace folder", },
    {
        '<space>wl',
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "LSP: list workspace folders",

    },
    { '<space>D',  vim.lsp.buf.type_definition,    desc = "LSP: show type definition", },
    { '<space>rn', vim.lsp.buf.rename,             desc = "LSP: rename", },
    { '<space>ca', '<cmd>Lspsaga code_action<cr>', desc = "LSPSaga: show code actions", mode = { 'n', 'v' }, },
    {
        '<space>f',
        function()
            require('conform').format()
            vim.lsp.buf.format { async = true }
        end,
        desc = "LSP: format file",
    },

    --------------
    -- Neotree  --
    --------------
    { "<space>nt", "<Cmd>Neotree toggle<CR>",                                   desc = "Neotree: toggle on the side" },
    { "<F2>",      "<Cmd>Neotree filesystem reveal float<CR>",                  desc = "Neotree: toggle floating window" },

    ---------------
    --Persistence--
    ---------------
    { "<space>sl", function() require("persistence").load() end,                desc = "Persistence: load session for current directory" },
    { "<space>ss", function() require("persistence").select() end,              desc = "Persistence: select session" },
    { "<space>so", function() require("persistence").load({ last = true }) end, desc = "Persistence: load last session" },
    { "<space>sq", function() require("persistence").stop() end,                desc = "Persistence: stop session (won't be saved on exit)" },

    ---------------
    --    SSR    --
    ---------------
    { "fr",        function() require("ssr").open() end,                        desc = "SSR: start Structual Search and Replace" },

    ---------------
    -- Telescope --
    ---------------
    { 'ff',        '<cmd>Telescope find_files<cr>',                             desc = "Telescope: find file" },
    { 'fg',        '<cmd>Telescope current_buffer_fuzzy_find<cr>',              desc = "Telescope: find in current buffer" },
    {
        'fg',
        function()
            local text = vim.getVisualSelection()
            require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })
        end,
        desc = "Telescope: find in current buffer",
        mode = 'v',
        { noremap = true, silent = true }
    },
    {
        'fG',
        function()
            local text = vim.getVisualSelection()
            require('telescope.builtin').live_grep({ default_text = text })
        end,
        desc = "Telescope: global find",
        mode = 'v',
        { noremap = true, silent = true }
    },
    { 'fG',        '<cmd>Telescope live_grep<cr>',                           desc = "Telescope: global find" },
    { 'fb',        '<cmd>Telescope buffers<cr>',                             desc = "Telescope: find buffer" },
    { 'fh',        '<cmd>Telescope help_tags<cr>',                           desc = "Telescope: find help tags" },
    { 'fv',        '<cmd>Telescope command_history<cr>',                     desc = "Telescope: find command history" },
    { 'fc',        '<cmd>Telescope commands<cr>',                            desc = "Telescope: find commands" },
    { 'fi',        '<cmd>Telescope lsp_implementations<cr>',                 desc = "Telescope: find LSP implementations" },
    { 'fu',        '<cmd>Telescope treesitter default_text=function\\ <cr>', desc = "Telescope: find function in treesitter" },
    { 'ft',        '<cmd>Telescope treesitter<cr>',                          desc = "Telescope: find element in treesitter" },
    { 'gd',        '<cmd>Telescope lsp_definitions<cr>',                     desc = "Telescope: find LSP definitions" },
    { '<space>D',  '<cmd>Telescope lsp_type_definitions<cr>',                desc = "Telescope: find LSP type definitions" },
    { '<space>ts', ':Telescope ',                                            desc = "Telescope: start finding" },

    ---------------
    --    Tmux   --
    ---------------
    { '<A-H>',     '<cmd>lua require("tmux").move_left()<cr>',               desc = "Tmux: move pane left" },
    { '<A-L>',     '<cmd>lua require("tmux").move_right()<cr>',              desc = "Tmux: move pane right" },
    { '<A-K>',     '<cmd>lua require("tmux").move_top()<cr>',                desc = "Tmux: move pane top" },
    { '<A-J>',     '<cmd>lua require("tmux").move_bottom()<cr>',             desc = "Tmux: move pane bottom" },

    { '<C-A-h>',   '<cmd>lua require("tmux").resize_left()<cr>',             desc = "Tmux: resize pane left" },
    { '<C-A-l>',   '<cmd>lua require("tmux").resize_right()<cr>',            desc = "Tmux: resize pane right" },
    { '<C-A-k>',   '<cmd>lua require("tmux").resize_top()<cr>',              desc = "Tmux: resize pane up" },
    { '<C-A-j>',   '<cmd>lua require("tmux").resize_bottom()<cr>',           desc = "Tmux: resize pane down" },

    ---------------
    --  Trouble  --
    ---------------
    { "<space>wd", "<cmd>Trouble diagnostics toggle<cr>",                    desc = "Trouble: workspace diagnostics", },
    { "<F3>",      "<cmd>Trouble symbols toggle focus=false<cr>",            desc = "Trouble: show outline", },

    ---------------
    -- Which-key --
    ---------------
    {
        "<space>?",
        function()
            require("which-key").show({ global = true })
        end,
        desc = "Which-key: Buffer Local Keymaps",
    },

    ---------------
    --   Jdtls   --
    ---------------
    {
        '<space>tc',
        function()
            require 'jdtls'.compile()
            require 'jdtls'.test_class()
        end,
        desc = "Jdtls: debug current test class"
    },
    {
        '<space>tm',
        function()
            require 'jdtls'.compile()
            require 'jdtls'.test_nearest_method()
        end,
        desc = "Jdtls: debug current test method"
    },
})
