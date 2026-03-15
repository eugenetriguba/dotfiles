vim.pack.add {
  {
    name = 'nord',
    src = 'https://github.com/shaunsingh/nord.nvim',
  },
}

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_uniform_diff_background = true
vim.g.nord_italic = false
vim.g.nord_bold = false

require('nord').set()
vim.cmd.colorscheme 'nord'
