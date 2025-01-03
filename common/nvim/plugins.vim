lua << END
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local function is_dap_buffer()
  return require("cmp_dap").is_dap_buffer()
end

require("lazy").setup(
 {
 {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
    end,
},
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
  },
},
{
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
  },
{ "anuvyklack/windows.nvim",
   dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
   },
   opts = {}
},
{
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            outline = {
                layout = 'float'
            }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
},
{
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  }
},
{
    'mfussenegger/nvim-jdtls',
    dependencies = {
        'mfussenegger/nvim-dap',
    }
},
{
	"L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
    end,
},
{
  "0xstepit/flow.nvim",
  lazy = false,
  priority = 1000,
  opts = {
      theme = {
        style = "dark", --  "dark" | "light"
        contrast = "default", -- "default" | "high"
        transparent = true, -- true | false
      },
      colors = {
        mode = "default", -- "default" | "dark" | "light"
        fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
      },
      ui = {
        borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = false, -- true | false
      },
  },
  config = function(_, opts)
        require("flow").setup(opts)
  end,
},
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
      fps = 120, -- frames per second. Global setting for all animations
    },
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = {
      enabled = false,
      timeout = 3000,
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
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
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
    { "<space>z",  function() Snacks.zen() end, desc = "Snacks: Toggle Zen Mode" },
    { "<space>Z",  function() Snacks.zen.zoom() end, desc = "Snacks: Toggle Zoom" },
    { "<space>.",  function() Snacks.scratch() end, desc = "Snacks: Toggle Scratch Buffer" },
    { "<space>S",  function() Snacks.scratch.select() end, desc = "Snacks: Select Scratch Buffer" },
    { "<space>n",  function() Snacks.notifier.show_history() end, desc = "Snacks: Notification History" },
    { "<space>bd", function() Snacks.bufdelete() end, desc = "Snacks: Delete Buffer" },
    { "<space>cR", function() Snacks.rename.rename_file() end, desc = "Snacks: Rename File" },
    { "<space>gB", function() Snacks.gitbrowse() end, desc = "Snacks: Git Browse", mode = { "n", "v" } },
    { "<space>gb", function() Snacks.git.blame_line() end, desc = "Snacks: Git Blame Line" },
    { "<space>gf", function() Snacks.lazygit.log_file() end, desc = "Snacks: Lazygit Current File History" },
    { "<space>gg", function() Snacks.lazygit() end, desc = "Snacks: Lazygit" },
    { "<space>gl", function() Snacks.lazygit.log() end, desc = "Snacks: Lazygit Log (cwd)" },
    { "<space>un", function() Snacks.notifier.hide() end, desc = "Snacks: Dismiss All Notifications" },
    { "<F4>",      function() Snacks.terminal() end, desc = "Snacks: Toggle Terminal" },
    { "<c-_>",     function() Snacks.terminal() end, desc = "Snacks: which_key_ignore" },
    { "<space>wn", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Snacks: Next Reference", mode = { "n" } },
    { "<space>wN", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Snacks: Prev Reference", mode = { "n" } },
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
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<space>uc")
        Snacks.toggle.treesitter():map("<space>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<space>ub")
        Snacks.toggle.inlay_hints():map("<space>uh")
        Snacks.toggle.indent():map("<space>ug")
        Snacks.toggle.dim():map("<space>uD")
      end,
    })
  end,
},
{
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = true,  -- if you want to enable the plugin
        message_template = "       <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
    config = function(_, opts)
      require('gitblame').setup {
         --Note how the `gitblame_` prefix is omitted in `setup`
        enabled = true,
      }
    end,
},
{ 
    'echasnovski/mini.surround', 
    version = false, 
    event = "VeryLazy", 
    config = function()
        require('mini.surround').setup({
            mappings = {
                add = '<space>sa', -- Add surrounding in Normal and Visual modes
                delete = '<space>sd', -- Delete surrounding
                find = '<space>sf', -- Find surrounding (to the right)
                find_left = '<space>sF', -- Find surrounding (to the left)
                highlight = '<space>sh', -- Highlight surrounding
                replace = '<space>sr', -- Replace surrounding
                update_n_lines = '<space>sn', -- Update `n_lines`

                suffix_last = 'l', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
            },   
        })
    end,
},
 {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
},
{
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<space>wd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Trouble: workspace diagnostics",
    },
    {
      "<F3>",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Trouble: show outline",
    },
  },
},

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
  dependencies = {'rafamadriz/friendly-snippets', 'rcarriga/cmp-dap'},

  -- use a release tag to download pre-built binaries
  version = 'v0.9.0',
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
          treesitter = {'lsp'},
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
      default = function(ctx)
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
          return { 'lsp', 'path', 'snippets', 'buffer' }
        end
      end,
      providers = {
        -- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        dap = { name = "dap", module = "blink.compat.source" },
        cmp_git = { name = "cmp_git", module = "blink.compat.source" },
        cmdline = { name = "cmdline", module = "blink.compat.source" },
      },
    },
  },
  opts_extend = { "sources.default" }
},
 'talha-akram/noctis.nvim',
 'EdenEast/nightfox.nvim',
 'rebelot/kanagawa.nvim',
 'marko-cerovac/material.nvim',
 'nvim-neotest/nvim-nio',
 'Shatur/neovim-ayu',
  'goolord/alpha-nvim',
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "folke/neodev.nvim",
   'goolord/alpha-nvim', -- Splash Screen
 'nvim-lualine/lualine.nvim', -- Status Bar
 'kvrohit/mellow.nvim', -- Color Scheme
 'ggandor/leap.nvim',
 'nvim-telescope/telescope-dap.nvim',
 'lukas-reineke/indent-blankline.nvim',
 'tpope/vim-repeat',
 'ggandor/flit.nvim',
 'aserowy/tmux.nvim',
 'jamestthompson3/nvim-remote-containers',
 'cshuaimin/ssr.nvim',
 'folke/tokyonight.nvim',
 'xiyaowong/transparent.nvim',
 'romgrk/barbar.nvim', -- Tabs
 {
   'folke/which-key.nvim',
   dependencies = {
    'echasnovski/mini.icons',
   }
 }, -- Key Suggestions
 'nvim-tree/nvim-tree.lua', -- File Explorer
 'MunifTanjim/nui.nvim',
 'nvim-neo-tree/neo-tree.nvim',
 'nvim-telescope/telescope.nvim', -- File Search
 { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
 {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install'}, -- Markdown Preview
 'rcarriga/nvim-notify', -- Notification Boxes
 'xiyaowong/nvim-transparent', -- Transparent Background
 {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
 'nvim-treesitter/nvim-treesitter-textobjects',
--  'wakatime/vim-wakatime' -- Time Logging
 'ap/vim-css-color', -- CSS Color Preview
 'kyazdani42/nvim-web-devicons', -- Status Bar Icons
 'ryanoasis/vim-devicons', -- Developer Icons
 'nvim-lua/plenary.nvim', -- Telescope Dependency
--  'sbdchd/neoformat' -- Auto formatter
 'williamboman/mason.nvim',
 'williamboman/mason-lspconfig.nvim',
 'jay-babu/mason-nvim-dap.nvim',
 'mfussenegger/nvim-dap',
 'rcarriga/nvim-dap-ui',
 'mfussenegger/nvim-dap-python',
 {'LiadOz/nvim-dap-repl-highlights', config = function() require('nvim-dap-repl-highlights').setup() end },
 'rcarriga/cmp-dap',
 'folke/neodev.nvim',
 'p00f/clangd_extensions.nvim',
 'numToStr/Comment.nvim',
 'slyces/hierarchy.nvim',
 'sindrets/diffview.nvim',
 'stevearc/conform.nvim',
 'lewis6991/hover.nvim',
 'folke/noice.nvim',
 'windwp/nvim-autopairs',
 'stevearc/aerial.nvim',
 'ray-x/lsp_signature.nvim',
 'lewis6991/gitsigns.nvim',
 -- 'airblade/vim-gitgutter',

-- Extra Syntax Highlighting
 'othree/html5.vim',
 'pangloss/vim-javascript',

-- Auto complete
{
    'neovim/nvim-lspconfig', 
    dependencies = {
        'saghen/blink.cmp'
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
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
    end
},
 'hrsh7th/cmp-nvim-lsp',
 'hrsh7th/cmp-buffer',
 'hrsh7th/cmp-path',
 'hrsh7th/cmp-cmdline',
 -- 'hrsh7th/nvim-cmp',

-- For vsnip users.
--  'hrsh7th/cmp-vsnip'
--  'hrsh7th/vim-vsnip'

-- For luasnip users.
 'saadparwaiz1/cmp_luasnip'
},
{lockfile = os.getenv('HOME') .. "/.config/lazy-lock.json",})



END

" Reference additional plugin configuration
runtime ./plugins/alpha.vim
runtime ./plugins/lualine.vim
runtime ./plugins/telescope.vim
" runtime ./plugins/nvim-tree.vim
runtime ./plugins/neo-tree.vim
runtime ./plugins/nvim-treesitter.vim
runtime ./plugins/which-key.vim
runtime ./plugins/neotest.vim
" runtime ./plugins/cmp.vim
runtime ./plugins/mason.vim
runtime ./plugins/dap.vim
runtime ./plugins/lsp.vim
runtime ./plugins/noice.vim
runtime ./plugins/tmux.vim
" runtime ./plugins/neoformat.vim
runtime ./plugins/indentline.vim
runtime ./plugins/barbar.vim
runtime ./plugins/ssr.vim
runtime ./plugins/gitsigns.vim
runtime ./plugins/leap.vim
runtime ./plugins/transparent.vim
runtime ./plugins/trouble.vim
runtime ./plugins/diffview.vim
runtime ./plugins/persistence.vim
