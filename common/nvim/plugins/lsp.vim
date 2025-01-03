lua << END
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

require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

require("conform").setup({
  formatters_by_ft = {
    vim = { "vint" },
    -- -- Conform will run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { "rustfmt", lsp_format = "fallback" },
    -- -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

require('Comment').setup()

require('aerial').setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    require("which-key").add({
      {'{', '<cmd>AerialPrev<CR>', desc = "Aerial: jump previous", {buffer = bufnr}},
      {'}', '<cmd>AerialNext<CR>', desc = "Aerial: jump next", {buffer = bufnr}},
    })
  end
})

-- Global mappings.
require("which-key").add({
  -- You probably also want to set a keymap to toggle aerial
  -- {'<F3>', '<cmd>AerialToggle!<CR>', desc = "Aerial: toggle UI"},
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  {'<space>e', vim.diagnostic.open_float, desc = "LSP: open floating diagnostic"},
  {'<space>q', vim.diagnostic.setloclist, desc = "LSP: diagnostic set local list"},
  {'[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = "LSPSaga: jump to previous diagnostic"},
  {']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = "LSPSaga: jump to next diagnostic"},
  {'fm', '<cmd>Lspsaga outline<cr>', desc = "LSPSaga: show file outline"},
  {'gr', '<cmd>Lspsaga finder<cr>', desc = "LSPSaga: find reference"},
  {'fs', '<cmd>Lspsaga subtypes<cr>', desc = "LSPSaga: show subtypes"},
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    require("which-key").add({
      {'gD', vim.lsp.buf.declaration, desc = "LSP: go to declaration", opts},
      {'K', vim.lsp.buf.hover, desc = "LSP: show hover info", opts},
      {'gi', vim.lsp.buf.implementation, desc = "LSP: go to implementation", opts},
      {'<C-k>', vim.lsp.buf.signature_help, desc = "LSP: show signature help", opts},
      {'<space>wa', vim.lsp.buf.add_workspace_folder, desc = "LSP: add workspace folder", opts},
      {'<space>wr', vim.lsp.buf.remove_workspace_folder, desc = "LSP: remove workspace folder", opts},
      {'<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, desc = "LSP: list workspace folders", opts},
      {'<space>D', vim.lsp.buf.type_definition, desc = "LSP: show type definition", opts},
      {'<space>rn', vim.lsp.buf.rename, desc = "LSP: rename", opts},
      {'<space>ca', '<cmd>Lspsaga code_action<cr>', desc = "LSPSaga: show code actions", mode = {'n', 'v'}, opts},
      {'<space>f', function()
          require('conform').format()
          vim.lsp.buf.format { async = true }
      end, desc = "LSP: format file", opts},
    })
  end,
})

require('lspconfig').ruff.setup({
  
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

require('lspconfig').pyright.setup {
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

END

nnoremap <silent> <A-o> :ClangdSwitchSourceHeader<CR>
