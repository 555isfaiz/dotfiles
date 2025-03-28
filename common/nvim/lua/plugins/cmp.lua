return {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    -- For luasnip users.
    { 'saadparwaiz1/cmp_luasnip', event = "VeryLazy" },
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    -- {
    --     'hrsh7th/nvim-cmp',
    --     dependencies = { 'rafamadriz/friendly-snippets', 'rcarriga/cmp-dap' },
    --     config = function()
    --         local types = require("cmp.types")
    --         local compare = require("cmp.config.compare")
    --
    --         local kind_icons = {
    --             Text = "",
    --             Method = "",
    --             Function = "󰊕",
    --             Constructor = "󰡱",
    --             Field = "",
    --             Variable = "󰫧",
    --             Class = "",
    --             Interface = "",
    --             Module = "󰕳",
    --             Property = "",
    --             Unit = "",
    --             Value = "󰇼",
    --             Enum = "",
    --             Keyword = "",
    --             Snippet = "",
    --             Color = "",
    --             File = "󰈔",
    --             Reference = "",
    --             Folder = "󰉋",
    --             EnumMember = "",
    --             Constant = "",
    --             Struct = "",
    --             Event = "",
    --             Operator = "ﬦ",
    --             TypeParameter = "",
    --         }
    --
    --         -- Set up nvim-cmp.
    --         local has_words_before = function()
    --             unpack = unpack or table.unpack
    --             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --             return col ~= 0 and
    --                 vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --         end
    --
    --         local modified_priority = {
    --             [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
    --             [types.lsp.CompletionItemKind.Snippet] = 100, -- top
    --             [types.lsp.CompletionItemKind.Keyword] = 100, -- top
    --             [types.lsp.CompletionItemKind.Text] = 100,  -- bottom
    --         }
    --         ---@param kind integer: kind of completion entry
    --         local function modified_kind(kind)
    --             return modified_priority[kind] or kind
    --         end
    --
    --         local luasnip = require("luasnip")
    --         local cmp = require("cmp")
    --
    --         cmp.setup({
    --             snippet = {
    --                 -- REQUIRED - you must specify a snippet engine
    --                 expand = function(args)
    --                     -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    --                     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --                     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    --                     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    --                 end,
    --             },
    --             window = {
    --                 completion = cmp.config.window.bordered(),
    --                 documentation = cmp.config.window.bordered(),
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --                 ['<A-/>'] = cmp.mapping.complete(),
    --                 ['<C-e>'] = cmp.mapping.abort(),
    --                 ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --                 ["<Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --                         -- they way you will only jump inside the snippet region
    --                     elseif luasnip.expand_or_jumpable() then
    --                         luasnip.expand_or_jump()
    --                     elseif has_words_before() then
    --                         cmp.complete()
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --
    --                 ["<S-Tab>"] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     elseif luasnip.jumpable(-1) then
    --                         luasnip.jump(-1)
    --                     else
    --                         fallback()
    --                     end
    --                 end, { "i", "s" }),
    --             }),
    --             sorting = {
    --                 comparators = {
    --                     compare.offset,
    --                     compare.exact,
    --                     compare.recently_used,
    --                     function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
    --                         local kind1 = modified_kind(entry1:get_kind())
    --                         local kind2 = modified_kind(entry2:get_kind())
    --                         if kind1 ~= kind2 then
    --                             return kind1 - kind2 < 0
    --                         end
    --                     end,
    --                     function(entry1, entry2) -- score by lsp, if available
    --                         local t1 = entry1.completion_item.sortText
    --                         local t2 = entry2.completion_item.sortText
    --                         if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
    --                             return t1 < t2
    --                         end
    --                     end,
    --                     compare.score,
    --                     compare.order,
    --                     function(entry1, entry2) -- sort by length ignoring "=~"
    --                         local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
    --                         local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
    --                         if len1 ~= len2 then
    --                             return len1 - len2 < 0
    --                         end
    --                     end,
    --                 },
    --             },
    --             formatting = {
    --                 fields = { "kind", "abbr", "menu" },
    --                 format = function(entry, vim_item)
    --                     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --                     -- vim_item.menu = ({
    --                     -- 	nvim_lsp = "",
    --                     -- 	luasnup = "",
    --                     -- 	buffer = "",
    --                     -- 	path = "",
    --                     -- })[entry.source.name]
    --                     vim_item.menu = entry:get_completion_item().detail
    --                     return vim_item
    --                 end,
    --             },
    --             sources = cmp.config.sources({
    --                 { name = 'nvim_lsp' },
    --                 -- { name = 'vsnip' }, -- For vsnip users.
    --                 { name = 'luasnip' }, -- For luasnip users.
    --                 -- { name = 'ultisnips' }, -- For ultisnips users.
    --                 -- { name = 'snippy' }, -- For snippy users.
    --                 { name = 'buffer' },
    --             }, {
    --             })
    --         })
    --
    --         -- Set configuration for specific filetype.
    --         cmp.setup.filetype('gitcommit', {
    --             sources = cmp.config.sources({
    --                 { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    --             }, {
    --                 { name = 'buffer' },
    --             })
    --         })
    --
    --         cmp.setup.filetype('snacks_input', {
    --             sources = cmp.config.sources({
    --                 { name = 'buffer' },
    --             })
    --         })
    --
    --         cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    --             sources = {
    --                 { name = "dap" },
    --             },
    --         })
    --
    --         cmp.setup({
    --             enabled = function()
    --                 return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    --                     or require("cmp_dap").is_dap_buffer()
    --             end
    --         })
    --
    --         -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    --         cmp.setup.cmdline({ '/', '?' }, {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = {
    --                 { name = 'buffer' }
    --             }
    --         })
    --
    --         -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    --         cmp.setup.cmdline(':', {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 { name = 'path' }
    --             }, {
    --                 { name = 'cmdline' }
    --             })
    --         })
    --
    --         -- Set up lspconfig.
    --         local capabilities = require('cmp_nvim_lsp').default_capabilities()
    --         -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    --         require('lspconfig')['eslint'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['quick_lint_js'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['jsonls'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['ts_ls'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['lua_ls'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['hls'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['rust_analyzer'].setup {
    --             capabilities = capabilities
    --         }
    --         require('lspconfig')['clangd'].setup {
    --             capabilities = capabilities
    --         }
    --
    --         local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    --         cmp.event:on(
    --             'confirm_done',
    --             cmp_autopairs.on_confirm_done()
    --         )
    --     end
    -- }
}
