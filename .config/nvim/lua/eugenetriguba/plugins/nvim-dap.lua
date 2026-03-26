vim.pack.add {
  {
    name = 'nvim-dap',
    src = 'https://github.com/mfussenegger/nvim-dap',
    version = '0.10.0',
  },
  {
    name = 'osv',
    src = 'https://github.com/jbyuki/one-small-step-for-vimkind',
    version = 'main',
  },
}

local dap = require 'dap'
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
end

vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { noremap = true, desc = '[D]ebug [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', require('dap').continue, { noremap = true, desc = '[D]ebug [C]ontinue' })
vim.keymap.set('n', '<leader>do', require('dap').step_over, { noremap = true, desc = '[D]ebug Step [O]ver' })
vim.keymap.set('n', '<leader>di', require('dap').step_into, { noremap = true, desc = '[D]ebug Step [I]nto' })

vim.keymap.set('n', '<leader>dl', function()
  require('osv').launch { port = 8086 }
end, { noremap = true, desc = '[D]ebug [L]ua' })

vim.keymap.set('n', '<leader>dw', function()
  local widgets = require 'dap.ui.widgets'
  widgets.hover()
end)

vim.keymap.set('n', '<leader>df', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.frames)
end)
