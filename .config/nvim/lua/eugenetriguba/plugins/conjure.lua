-- Remap the documentation word mapping so it doesn't conflict
-- with our LSP mapping.
vim.g['conjure#mapping#doc_word'] = 'gk'

-- Only use conjure for certain languages.
vim.g['conjure#filetype'] = { 'scheme', 'lisp', 'fennel', 'lua', 'cl' }

-- Map .lisp and .cl files to the Common Lisp swank client, not nREPL.
vim.g['conjure#filetype#cl'] = 'conjure.client.common-lisp.swank'
vim.g['conjure#filetype#lisp'] = 'conjure.client.common-lisp.swank'

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.g['conjure#filetype'],
  once = true,
  callback = function()
    vim.pack.add {
      {
        name = 'conjure',
        src = 'https://github.com/Olical/conjure',
        version = 'v4.59.0',
      },
      {
        name = 'parinfer-rust',
        src = 'https://github.com/eraserhd/parinfer-rust',
        version = 'master',
      },
    }
  end,
})
