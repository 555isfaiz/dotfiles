vim.o.autoindent = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.number = true
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.o.mouse="a"
vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
vim.o.pumheight=10
vim.cmd("set noshowmode")
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.updatetime=100
vim.o.laststatus=3
vim.o.spell = true
vim.o.cursorline = true
vim.o.spelllang="en_us"
vim.o.signcolumn = 'yes:3'

vim.g.mapleader = " "

vim.cmd("colorscheme nordfox")
