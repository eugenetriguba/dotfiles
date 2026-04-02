vim.pack.add {
  {
    name = 'lazydev.nvim',
    src = 'https://github.com/folke/lazydev.nvim',
  },
  {
    name = 'nvim-lspconfig',
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
  {
    name = 'fidget.nvim',
    src = 'https://github.com/j-hui/fidget.nvim',
  },
}

require('fidget').setup {}
require('lazydev').setup {
  enabled = function(root_dir)
    local lazydev_enabled = function()
      return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    end
    local is_lua_neovim_config_file = function()
      return vim.bo.filetype == 'lua' and vim.fn.expand('%:p'):find(vim.fn.stdpath 'config', 1, true) ~= nil
    end
    return lazydev_enabled() or is_lua_neovim_config_file()
  end,
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local fzf = require 'fzf-lua'
    fzf.register_ui_select({}, true)
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', fzf.lsp_code_actions, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', fzf.lsp_references, '[G]oto [R]eferences')
    map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
    map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
    map('grD', fzf.lsp_declarations, '[G]oto [D]eclaration')
    map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
    map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')
    map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = 'cursor',
      border = 'rounded',
      source = 'if_many',
      close_events = { 'CursorMoved', 'InsertEnter', 'BufLeave', 'WinLeave' },
    })
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = false,
}

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('harper_ls', {
  filetypes = { 'markdown', 'gitcommit', 'asciidoc' },
  settings = {
    ['harper-ls'] = {
      diagnosticSeverity = 'warning',
      linters = {
        SpellCheck = false,
      },
    },
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
})

vim.lsp.config('jdtls', {
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = 'interactive',
        refreshBundles = true,
      },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
        },
      },
      contentProvider = { preferred = 'fernflower' },
      eclipse = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      saveActions = {
        organizeImports = true,
      },
      signatureHelp = { enabled = true },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
})

vim.lsp.enable {
  'harper_ls',
  'lua_ls',
  'ansiblels',
  'clangd',
  'gopls',
  'ty',
  'yamlls',
  'rust_analyzer',
  'ts_ls',
  'terraformls',
  'bashls',
  'jdtls',
  'kotlin_lsp',
}
