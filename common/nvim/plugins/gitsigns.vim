lua << END
require('gitsigns').setup {
  signs = {
    add          = { text = '' },
    change       = { text = '' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '' },
    change       = { text = '' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    -- map('n', ']c', function()
    --   if vim.wo.diff then return ']c' end
    --   vim.schedule(function() gs.next_hunk() end)
    --   return '<Ignore>'
    -- end, {expr=true})
    --
    -- map('n', '[c', function()
    --   if vim.wo.diff then return '[c' end
    --   vim.schedule(function() gs.prev_hunk() end)
    --   return '<Ignore>'
    -- end, {expr=true})

    -- Actions
    require("which-key").add({
      {'<space>hs', gs.stage_hunk, desc = "Git hunk: stage hunk"},
      {'<space>hr', gs.reset_hunk, desc = "Git hunk: reset hunk"},
      {'<space>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Git hunk: stage hunk", mode = "v"},
      {'<space>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Git hunk: reset hunk", mode = "v"},
      {'<space>hS', gs.stage_buffer, desc = "Git hunk: stage buffer"},
      {'<space>hu', gs.undo_stage_hunk, desc = "Git hunk: undo stage buffer"},
      {'<space>hR', gs.reset_buffer, desc = "Git hunk: reset buffer"},
      {'<space>hp', gs.preview_hunk, desc = "Git hunk: preview hunk"},
      {'<space>hb', function() gs.blame_line{full=true} end, desc = "Git hunk: blame file"},
      {'<space>tb', gs.toggle_current_line_blame, desc = "Git hunk: blame line"},
      {'<space>hd', gs.diffthis, desc = "Git hunk: diff hunk"},
      {'<space>hD', function() gs.diffthis('~') end, desc = "Git hunk: diff file"},
      {'<space>td', gs.toggle_deleted, desc = "Git hunk: toggle deleted"},
      {'[c', function()
          if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
      end, desc = "Git hunk: go to previous change", {expr=true}},
      {']c', function()
          if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
      end, desc = "Git hunk: go to next change", {expr=true}},
      {'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = "Git hunk: select hunk", mode = {'o', 'x'}},
    })

  end
}
END
