" This is the bar that shows at the bottom of the active window

lua << END

require('lualine').setup {
	options = {
			component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            theme = "tokyonight",
			disabled_filetypes = { "neo-tree", "dapui_scopes", "dashboard", "Outline", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl", "dapui_console", "aerial"}
		},
	sections = {
		lualine_b = {
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				sections = { 'error', 'warn' },
				symbols = {error = " ", warn = " ", info = " ", hint = "󰌵 " },
				always_visible = true
			}
		},
		lualine_x = {"location", "filetype"}
		}
	}
END
