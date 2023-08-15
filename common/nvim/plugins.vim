" Import All plugins

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

require("lazy").setup({
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
 'cshuaimin/ssr.nvim',
 'folke/tokyonight.nvim',
 'romgrk/barbar.nvim', -- Tabs
 'folke/which-key.nvim', -- Key Suggestions
 'nvim-tree/nvim-tree.lua', -- File Explorer
 'MunifTanjim/nui.nvim',
 'nvim-neo-tree/neo-tree.nvim',
 'nvim-telescope/telescope.nvim', -- File Search
 { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
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
 'folke/trouble.nvim', -- Error box
 'williamboman/mason.nvim',
 'williamboman/mason-lspconfig.nvim',
 'jay-babu/mason-nvim-dap.nvim',
 'mfussenegger/nvim-dap',
 'rcarriga/nvim-dap-ui',
 'mfussenegger/nvim-jdtls',
 'mfussenegger/nvim-dap-python',
 'LiadOz/nvim-dap-repl-highlights',
 'rcarriga/cmp-dap',
 'folke/neodev.nvim',
 'p00f/clangd_extensions.nvim',
 'numToStr/Comment.nvim',
 'slyces/hierarchy.nvim',
 'jose-elias-alvarez/null-ls.nvim',
 'lewis6991/hover.nvim',
 'folke/noice.nvim',
 'windwp/nvim-autopairs',
 'stevearc/aerial.nvim',
 'ray-x/lsp_signature.nvim',
 'airblade/vim-gitgutter',

-- Extra Syntax Highlighting
 'othree/html5.vim',
 'pangloss/vim-javascript',

-- Auto complete
 'neovim/nvim-lspconfig',
 'hrsh7th/cmp-nvim-lsp',
 'hrsh7th/cmp-buffer',
 'hrsh7th/cmp-path',
 'hrsh7th/cmp-cmdline',
 'hrsh7th/nvim-cmp',

-- For vsnip users.
--  'hrsh7th/cmp-vsnip'
--  'hrsh7th/vim-vsnip'

-- For luasnip users.
 'L3MON4D3/LuaSnip',
 'saadparwaiz1/cmp_luasnip'
})


END

" Reference additional plugin configuration
source ~/.config/nvim/plugins/alpha.vim
source ~/.config/nvim/plugins/lualine.vim
source ~/.config/nvim/plugins/telescope.vim
" source ~/.config/nvim/plugins/nvim-tree.vim
source ~/.config/nvim/plugins/neo-tree.vim
source ~/.config/nvim/plugins/nvim-treesitter.vim
source ~/.config/nvim/plugins/which-key.vim
source ~/.config/nvim/plugins/cmp.vim
source ~/.config/nvim/plugins/mason.vim
source ~/.config/nvim/plugins/dap.vim
source ~/.config/nvim/plugins/lsp.vim
source ~/.config/nvim/plugins/noice.vim
source ~/.config/nvim/plugins/tmux.vim
source ~/.config/nvim/plugins/neoformat.vim
source ~/.config/nvim/plugins/indentline.vim
source ~/.config/nvim/plugins/barbar.vim
source ~/.config/nvim/plugins/ssr.vim
source ~/.config/nvim/plugins/leap.vim
source ~/.config/nvim/plugins/trouble.vim
