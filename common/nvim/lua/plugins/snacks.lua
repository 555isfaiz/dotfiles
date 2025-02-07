return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            animate = {
                enabled = true,
                duration = 1, -- ms per step
                easing = "linear",
                fps = 120,    -- frames per second. Global setting for all animations
            },
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            indent = { enabled = false },
            input = { enabled = true },
            notifier = {
                enabled = false,
                timeout = 3000,
            },
            picker = {
                enabled = true,
                matcher = {
                    frecency = true,
                },
                win = {
                    -- input window
                    input = {
                        keys = {
                            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
                            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
                            ["<S-s>"] = { "select_and_prev", mode = { "n" } },
                            ["s"] = { "select_and_next", mode = { "n" } },
                        }
                    },
                    list = {
                        keys = {
                            ["<S-Tab>"] = { "list_up", mode = { "n", "x" } },
                            ["<Tab>"] = { "list_down", mode = { "n", "x" } },
                            ["<S-s>"] = { "select_and_prev", mode = { "n", "x" } },
                            ["s"] = { "select_and_next", mode = { "n", "x" } },
                        }
                    }
                }
            },
            quickfile = { enabled = true },
            scroll = {
                enabled = true,
                animate = {
                    duration = { step = 10, total = 100 },
                    easing = "linear",
                },
                spamming = 10, -- threshold for spamming detection
                -- what buffers to animate
                filter = function(buf)
                    return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and
                        vim.bo[buf].buftype ~= "terminal"
                end,
            },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            { "<space>z",  function() Snacks.zen() end,                           desc = "Snacks: Toggle Zen Mode" },
            { "<space>Z",  function() Snacks.zen.zoom() end,                      desc = "Snacks: Toggle Zoom" },
            { "<space>.",  function() Snacks.scratch() end,                       desc = "Snacks: Toggle Scratch Buffer" },
            { "<space>S",  function() Snacks.scratch.select() end,                desc = "Snacks: Select Scratch Buffer" },
            { "<space>n",  function() Snacks.notifier.show_history() end,         desc = "Snacks: Notification History" },
            { "<space>bd", function() Snacks.bufdelete() end,                     desc = "Snacks: Delete Buffer" },
            { "<space>cR", function() Snacks.rename.rename_file() end,            desc = "Snacks: Rename File" },
            { "<space>gB", function() Snacks.gitbrowse() end,                     desc = "Snacks: Git Browse",                  mode = { "n", "v" } },
            { "<space>gb", function() Snacks.git.blame_line() end,                desc = "Snacks: Git Blame Line" },
            { "<space>gf", function() Snacks.lazygit.log_file() end,              desc = "Snacks: Lazygit Current File History" },
            { "<space>gg", function() Snacks.lazygit() end,                       desc = "Snacks: Lazygit" },
            { "<space>gl", function() Snacks.lazygit.log() end,                   desc = "Snacks: Lazygit Log (cwd)" },
            { "<space>un", function() Snacks.notifier.hide() end,                 desc = "Snacks: Dismiss All Notifications" },
            { "<F4>",      function() Snacks.terminal() end,                      desc = "Snacks: Toggle Terminal" },
            -- { "<c-_>",     function() Snacks.terminal() end,                      desc = "Snacks: which_key_ignore" },
            { "<space>wn", function() Snacks.words.jump(vim.v.count1, true) end,  desc = "Snacks: Next Reference",              mode = { "n" } },
            { "<space>wN", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Snacks: Prev Reference",              mode = { "n" } },
            {
                "<space>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            }
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<space>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<space>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<space>uL")
                    Snacks.toggle.diagnostics():map("<space>ud")
                    Snacks.toggle.line_number():map("<space>ul")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<space>uc")
                    Snacks.toggle.treesitter():map("<space>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                        "<space>ub")
                    Snacks.toggle.inlay_hints():map("<space>uh")
                    Snacks.toggle.indent():map("<space>ug")
                    Snacks.toggle.dim():map("<space>uD")
                end,
            })
        end,
    }
}
