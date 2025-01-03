lua << END
require("dapui").setup()

if vim.fn.has('macunix') == 1 then
    require('dap.ext.vscode').load_launchjs(nil, {lldb = {'c', 'cpp'}})
else
    require('dap.ext.vscode').load_launchjs(nil, {cppdbg = {'c', 'cpp'}})
end
require('dap-python').setup('~/.pyvenv/bin/python')

local dap = require('dap')
local home_dir = os.getenv('HOME')

vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='DapBreakpoint', numhl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='ErrorMsg', linehl='DapBreakpoint', numhl='DapBreakpoint'})
vim.fn.sign_define('DapStopped', {text='→', texthl='ErrorMsg', linehl='DiffText', numhl='DiffText'})

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = home_dir .. '/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = home_dir .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

require("which-key").add({
  {'<F5>', require'dap'.continue, desc = "DAP: start or continue"},
  {'<F6>', require'dap'.terminate, desc = "DAP: terminate"},
  {'<F7>', require'dap'.restart, desc = "DAP: restart"},
  {'<F10>', require'dap'.step_over, desc = "DAP: step over"},
  {'<F11>', require'dap'.step_into, desc = "DAP: step into"},
  {'B', require'dap'.toggle_breakpoint, desc = "DAP: toggle breakpoint"},
  {'<Space>b', function()
    vim.ui.input({ prompt = 'Conditional Breakpoint: ' }, function(input)
        require'dap'.toggle_breakpoint(input)
    end)
  end, desc = "DAP: toggle conditional breakpoint"},
  {'<F1>', require'dapui'.toggle, desc = "DAP: toggle UI"},
  {"<space>ev", function()
    vim.ui.input({ prompt = 'Enter value for Evaluate: ', completion = 'command' }, function(input)
        require("dapui").eval(input)
    end)
  end, desc = "DAP: evaluate experssion"}
})

local dap = require('dap')
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "I" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'I')
      end
    end
  end
  api.nvim_set_keymap(
    'n', 'I', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { desc = "DAP: show hover variable info", silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end

END
