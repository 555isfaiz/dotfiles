lua << END
require('flit').setup {
    keys = { f = 't', F = 'T', t = 'r', T = 'R' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
}

require("which-key").add({
    {'s', '<Plug>(leap)', desc = "Leap: start leap", mode = {'n', 'x', 'o'}},
    {'<Space>l',  function ()
      require('leap.treesitter').select()
    end, desc = "Leap: start treesitter leap", mode = {'n', 'x', 'o'}},
    {'<Space>L', 'V<cmd>lua require("leap.treesitter").select()<cr>', desc = "Leap: start linewise treesitter leap", mode = {'n', 'x', 'o'}},
})

vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function ()
        -- if vim.g.colors_name == "noctis_bordo" then
          -- Force using the defaults of Leap:
          require('leap').init_highlight(true)
          -- And/or make your own tweaks:
          vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
          vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { link = 'Normal' })
          vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { link = 'Substitute' })
          vim.api.nvim_set_hl(0, 'LeapMatch', { link = 'ErrorMsg' })
          -- etc.
        -- end
      end
    })
END
