lua << END
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      view = "mini",
      filter = { event = "msg_show", blocking = true },
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "noice",
      "dap-float",
      -- "qf",
      -- "lspinfo",
      -- "man",
      -- "checkhealth",
    },
    command = [[
            nnoremap <buffer><silent> q :close<CR>
            nnoremap <buffer><silent> <Esc> :close<CR>
            set nobuflisted
        ]],
  })

-- Map <Esc> to close all windows with a specific filetype (e.g., 'help')
-- vim.keymap.set("n", "<Esc>", "<cmd>lua require('helpers').close_windows_with_filetype('noice')<cr>", { noremap = true, silent = true })
END
