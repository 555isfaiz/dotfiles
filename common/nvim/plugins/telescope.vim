lua << END

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

require("which-key").add({
    {'ff', '<cmd>Telescope find_files<cr>', desc = "Telescope: find file"},
    {'fg', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = "Telescope: find in current buffer"},
    {'fg', function()
        local text = vim.getVisualSelection()
        tb.current_buffer_fuzzy_find({ default_text = text })
    end, desc = "Telescope: find in current buffer", mode = 'v', opts},
    {'fG', function()
        local text = vim.getVisualSelection()
        tb.live_grep({ default_text = text })
    end, desc = "Telescope: global find", mode = 'v',opts},
    {'fG', '<cmd>Telescope live_grep<cr>', desc = "Telescope: global find"},
    {'fb', '<cmd>Telescope buffers<cr>', desc = "Telescope: find buffer"},
    {'fh', '<cmd>Telescope help_tags<cr>', desc = "Telescope: find help tags"},
    {'fv', '<cmd>Telescope command_history<cr>', desc = "Telescope: find command history"},
    {'fc', '<cmd>Telescope commands<cr>', desc = "Telescope: find commands"},
    {'fi', '<cmd>Telescope lsp_implementations<cr>', desc = "Telescope: find LSP implementations"},
    {'fu', '<cmd>Telescope treesitter default_text=function\\ <cr>', desc = "Telescope: find function in treesitter"},
    {'ft', '<cmd>Telescope treesitter<cr>', desc = "Telescope: find element in treesitter"},
    {'gd', '<cmd>Telescope lsp_definitions<cr>', desc = "Telescope: find LSP definitions"},
    {'<space>D', '<cmd>Telescope lsp_type_definitions<cr>', desc = "Telescope: find LSP type definitions"},
    {'<space>ts', ':Telescope ', desc = "Telescope: start finding"}
})

local telescope = require('telescope')
telescope.setup {
    defaults = {
        vimgrep_arguments = {
        'rg',
        '--no-heading',
        -- '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        -- '--hidden',
        },
    },
    extensions = {
        fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
END
