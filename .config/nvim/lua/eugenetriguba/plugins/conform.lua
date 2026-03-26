vim.pack.add {
  {
    name = 'conform.nvim',
    src = 'https://github.com/stevearc/conform.nvim',
  },
}
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable "format_on_save lsp_fallback" for certain languages.
    local disable_filetypes = { sql = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end
    return {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    }
  end,
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    lua = { 'stylua' },
    go = { 'gofmt' },
    python = { 'black', 'isort' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    tf = { 'terraform_fmt' },
    nix = { 'nixfmt' },
    java = { 'google-java-format' },
    md = { 'prettierd' },
    toml = { 'taplo' },
    yaml = { 'prettierd' },
    json = { 'prettierd' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    css = { 'prettierd' },
    htmldjango = { 'prettierd' },
    html = { 'prettierd' },
  },
  formatters = {
    isort = {
      prepend_args = { '--profile', 'black' },
    },
  },
}
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- :FormatDisable! disables autoformat for this buffer only
    vim.b.disable_autoformat = true
  else
    -- :FormatDisable disables autoformat globally
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true, -- allows the ! variant
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

vim.keymap.set('', '<leader>fb', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat [B]uffer' })

vim.keymap.set('n', '<leader>tf', function()
  -- If autoformat is currently disabled for this buffer,
  -- then enable it, otherwise disable it
  if vim.b.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat for current buffer'
  else
    vim.cmd 'FormatDisable!'
    vim.notify 'Disabled autoformat for current buffer'
  end
end, { desc = 'Toggle autoformat for current buffer' })

-- If autoformat is currently disabled globally,
-- then enable it globally, otherwise disable it globally
vim.keymap.set('n', '<leader>tF', function()
  if vim.g.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat globally'
  else
    vim.cmd 'FormatDisable'
    vim.notify 'Disabled autoformat globally'
  end
end, { desc = 'Toggle autoformat globally' })
