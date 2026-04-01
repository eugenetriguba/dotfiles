local opt_local = vim.opt_local

opt_local.textwidth = 80
opt_local.formatoptions:append { 't' }
opt_local.formatoptions:remove { 'l' }

opt_local.wrap = true
opt_local.linebreak = true
opt_local.breakindent = true

opt_local.spell = true
opt_local.spelllang = 'en_us'
opt_local.spellcapcheck = ''
opt_local.spellfile = vim.env.HOME .. '/.config/nvim/spell/en.utf-8.add'

opt_local.expandtab = true
opt_local.tabstop = 2
opt_local.shiftwidth = 2

opt_local.list = true
opt_local.listchars = 'tab:»·,trail:·'

opt_local.number = false
opt_local.relativenumber = false

-- Use macOS dictionary program as keyword look up
opt_local.keywordprg = 'open-dict'
