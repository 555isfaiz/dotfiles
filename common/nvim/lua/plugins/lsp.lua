return {
    {
        'nvimdev/lspsaga.nvim',
        event = 'VeryLazy',
        config = function()
            require('lspsaga').setup({
                outline = {
                    layout = 'float'
                },
                lightbulb = {
                    enable = false
                }
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.on_attach = function(client, bufnr)
                -- your on_attach function
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    },
    {
        'p00f/clangd_extensions.nvim',
        event = "VeryLazy",
        config = function()
            require("clangd_extensions").setup {
                server = {
                    -- options to pass to nvim-lspconfig
                    -- i.e. the arguments to require("lspconfig").clangd.setup({})
                },
                extensions = {
                    -- defaults:
                    -- Automatically set inlay hints (type hints)
                    autoSetHints = vim.fn.has("nvim-0.10") ~= 1,
                    -- These apply to the default ClangdSetInlayHints command
                    inlay_hints = {
                        inline = vim.fn.has("nvim-0.10") == 1,
                        -- Options other than `highlight' and `priority' only work
                        -- if `inline' is disabled
                        -- Only show inlay hints for the current line
                        only_current_line = false,
                        -- Event which triggers a refersh of the inlay hints.
                        -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
                        -- not that this may cause  higher CPU usage.
                        -- This option is only respected when only_current_line and
                        -- autoSetHints both are true.
                        only_current_line_autocmd = { "CursorHold" },
                        -- whether to show parameter hints with the inlay hints or not
                        show_parameter_hints = true,
                        -- prefix for parameter hints
                        parameter_hints_prefix = "<- ",
                        -- prefix for all the other hints (type, chaining)
                        other_hints_prefix = "=> ",
                        -- whether to align to the length of the longest line in the file
                        max_len_align = false,
                        -- padding from the left if max_len_align is true
                        max_len_align_padding = 1,
                        -- whether to align to the extreme right or not
                        right_align = false,
                        -- padding from the right if right_align is true
                        right_align_padding = 7,
                        -- The color of the hints
                        highlight = "Comment",
                        -- The highlight group priority for extmark
                        priority = 100,
                    },
                    ast = {
                        -- These are unicode, should be available in any font
                        role_icons = {
                            type = "🄣",
                            declaration = "🄓",
                            expression = "🄔",
                            statement = ";",
                            specifier = "🄢",
                            ["template argument"] = "🆃",
                        },
                        kind_icons = {
                            Compound = "🄲",
                            Recovery = "🅁",
                            TranslationUnit = "🅄",
                            PackExpansion = "🄿",
                            TemplateTypeParm = "🅃",
                            TemplateTemplateParm = "🅃",
                            TemplateParamObject = "🅃",
                        },
                        --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = "",
                        },

                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = "",
                        }, ]]

                        highlights = {
                            detail = "Comment",
                        },
                    },
                    memory_usage = {
                        border = "none",
                    },
                    symbol_info = {
                        border = "none",
                    },
                },
            }
        end
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    sql = { "sqlfmt" },
                    -- -- Conform will run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    -- -- You can customize some of the format options for the filetype (:help conform.format)
                    -- rust = { "rustfmt", lsp_format = "fallback" },
                    -- -- Conform will run the first available formatter
                    -- javascript = { "prettierd", "prettier", stop_after_first = true },
                    json = { "jq" },
                },
                default_format_opts = {
                    lsp_format = "fallback",
                },
            })
        end
    },
    -- {
    --     'stevearc/aerial.nvim',
    --     config = function()
    --         require('aerial').setup({
    --             backends = { "treesitter", "lsp", "markdown", "man" },
    --             keymaps = {
    --                 ["?"] = "actions.show_help",
    --                 ["g?"] = "actions.show_help",
    --                 ["<CR>"] = "actions.jump",
    --                 ["<2-LeftMouse>"] = "actions.jump",
    --                 ["<C-v>"] = "actions.jump_vsplit",
    --                 ["<C-s>"] = "actions.jump_split",
    --                 ["p"] = "actions.scroll",
    --                 ["<C-j>"] = "actions.down_and_scroll",
    --                 ["<C-k>"] = "actions.up_and_scroll",
    --                 ["{"] = "actions.prev",
    --                 ["}"] = "actions.next",
    --                 ["[["] = "actions.prev_up",
    --                 ["]]"] = "actions.next_up",
    --                 ["q"] = "actions.close",
    --                 ["o"] = "actions.tree_toggle",
    --                 ["za"] = "actions.tree_toggle",
    --                 ["O"] = "actions.tree_toggle_recursive",
    --                 ["zA"] = "actions.tree_toggle_recursive",
    --                 ["l"] = "actions.tree_open",
    --                 ["zo"] = "actions.tree_open",
    --                 ["L"] = "actions.tree_open_recursive",
    --                 ["zO"] = "actions.tree_open_recursive",
    --                 ["h"] = "actions.tree_close",
    --                 ["zc"] = "actions.tree_close",
    --                 ["H"] = "actions.tree_close_recursive",
    --                 ["zC"] = "actions.tree_close_recursive",
    --                 ["zr"] = "actions.tree_increase_fold_level",
    --                 ["zR"] = "actions.tree_open_all",
    --                 ["zm"] = "actions.tree_decrease_fold_level",
    --                 ["zM"] = "actions.tree_close_all",
    --                 ["zx"] = "actions.tree_sync_folds",
    --                 ["zX"] = "actions.tree_sync_folds",
    --             },
    --             layout = {
    --                 width = 0.6,
    --             },
    --             -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    --             on_attach = function(bufnr)
    --                 -- Jump forwards/backwards with '{' and '}'
    --                 require("which-key").add({
    --                     { '{', '<cmd>AerialPrev<CR>', desc = "Aerial: jump previous", { buffer = bufnr } },
    --                     { '}', '<cmd>AerialNext<CR>', desc = "Aerial: jump next",     { buffer = bufnr } },
    --                 })
    --             end
    --         })
    --     end
    -- },
    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        dependencies = {
            'saghen/blink.cmp',
            'williamboman/mason-lspconfig.nvim',
        },
        opts = {
            servers = {
                lua_ls = {},
                eslint = {},
                quick_lint_js = {},
                jsonls = {},
                ts_ls = {},
                hls = {},
                rust_analyzer = {},
                clangd = {}
            }
        },
        config = function(_, opts)
            vim.lsp.diagnostic.enable = true
            local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                -- local current_config = vim.diagnostic.config()
                -- if current_config == nil then
                --     current_config = {}
                -- end
                -- current_config['signs']['text']["DiagnosticSign" .. type] = icon
                -- current_config['signs']['texthl']["DiagnosticSign" .. type] = hl
                -- current_config['signs']['numhl']["DiagnosticSign" .. type] = hl
                -- vim.diagnostic.config(current_config)
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = 'LSP: Disable hover capability from Ruff',
            })

            local lspconfig = vim.lsp.config
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server] = config
                vim.lsp.enable(server)
            end

            vim.lsp.enable('ruff')

            lspconfig['pyright'] = {
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },
                        },
                    },
                },
            }

            vim.lsp.enable('pyright')
        end
    },
}
