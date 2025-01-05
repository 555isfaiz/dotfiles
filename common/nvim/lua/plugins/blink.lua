local function is_dap_buffer()
    return require("cmp_dap").is_dap_buffer()
end

return {
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {
            -- some plugins lazily register their completion source when nvim-cmp is
            -- loaded, so pretend that we are nvim-cmp, and that nvim-cmp is loaded.
            -- most plugins don't do this, so this option should rarely be needed
            -- NOTE: only has effect when using lazy.nvim plugin manager
            impersonate_nvim_cmp = true,

            -- print some debug information. Might be useful for troubleshooting
            debug = true,
        }
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets', 'rcarriga/cmp-dap' },

        -- use a release tag to download pre-built binaries
        version = '*',
        event = 'VeryLazy',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                -- set to 'none' to disable the 'default' preset
                preset = 'none',

                ['<A-/>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },

                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            enabled = function()
                return vim.bo.buftype ~= "prompt" or is_dap_buffer()
            end,

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                -- 'prefix' will fuzzy match on the text before the cursor
                -- 'full' will fuzzy match on the text before *and* after the cursor
                -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                keyword = { range = 'full' },

                -- Disable auto brackets
                -- NOTE: some LSPs may add auto brackets themselves anyway
                accept = { auto_brackets = { enabled = true }, },

                -- Insert completion item on selection, don't select by default
                list = { selection = 'auto_insert' },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                }
            },

            signature = { enabled = true },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = function()
                    local success, node = pcall(vim.treesitter.get_node)
                    if is_dap_buffer() then
                        return { "dap", "snippets", "buffer" }
                    elseif vim.bo.filetype == "gitcommit" then
                        return { 'cmp_git', 'buffer' }
                    elseif vim.bo.filetype == "snacks_input" then
                        return { "dap", "snippets", "buffer" }
                    elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                        return { 'buffer' }
                    else
                        return { "lazydev", 'lsp', 'path', 'snippets', 'buffer' }
                    end
                end,
                providers = {
                    -- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                    dap = { name = "dap", module = "blink.compat.source" },
                    cmp_git = { name = "cmp_git", module = "blink.compat.source" },
                    cmdline = { name = "cmdline", module = "blink.compat.source" },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    }
}