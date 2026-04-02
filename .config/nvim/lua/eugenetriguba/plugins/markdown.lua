vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_no_default_key_mappings = 1

-- Indentation for new lists. We don't insert bullets as it doesn't play
-- nicely with `gq` formatting. It relies on a hack of treating bullets
-- as comment characters.
-- See https://github.com/plasticboy/vim-markdown/issues/232
vim.g.vim_markdown_new_list_item_indent = 0
vim.g.vim_markdown_auto_insert_bullets = 0

-- Filetype names and aliases for fenced code blocks.
vim.g.vim_markdown_fenced_languages = { 'py=python', 'js=javascript', 'bash=sh', 'viml=vim' }

-- Highlight front matter
vim.g.vim_markdown_toml_frontmatter = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_frontmatter = 1

-- Format strike-through text (wrapped in `~~`).
vim.g.vim_markdown_strikethrough = 1

vim.pack.add {
  {
    name = 'markview.nvim',
    src = 'https://github.com/OXY2DEV/markview.nvim',
  },
  {
    name = 'vim-markdown',
    src = 'https://github.com/preservim/vim-markdown',
  },
}

require('markview').setup {
  -- Disable automatic previews.
  preview = { enable = false, icon_provider = 'mini' },
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>tm',
  '<CMD>Markview splitToggle<CR>',
  { desc = '[T]oggle a split `markview` preview.' }
)
