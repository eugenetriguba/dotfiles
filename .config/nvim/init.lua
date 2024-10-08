vim.g.mapleader = " "
vim.opt.scrolloff = 10
vim.g.python3_host_prog = "/Users/eugene/.pyenv/versions/3.11.5/bin/python"
vim.opt.visualbell = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shiftwidth = 4
vim.opt.backspace = { "indent", "eol", "start" }
vim.cmd("filetype plugin indent on")

-- Whitespace settings per filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.go",
  command = "setlocal noet tabstop=4 shiftwidth=4 softtabstop=4",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "java", "rust", "c", "cpp", "lua" },
  command = "setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2",
})

-- Automatically install packer.nvim if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand to reload Neovim whenever you save the init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Plugin manager setup using packer.nvim
require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Auto complete
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")

  -- Telescope for advanced searching
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- Telescope FZF extension
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Tags-based plugin for searching symbols
  use("ludovicchabant/vim-gutentags")

  -- Git gutter
  use("airblade/vim-gitgutter")

  -- Status bar
  use("nvim-lualine/lualine.nvim")

  -- Git wrapper with :G
  use("tpope/vim-fugitive")

  -- GitHub vim fugitive plugin
  use("tpope/vim-rhubarb")

  -- Editorconfig file support
  use("editorconfig/editorconfig-vim")

  -- Theme
  use("sainnhe/everforest")

  -- Go support
  use({ "fatih/vim-go", run = ":GoUpdateBinaries" })

  -- Treesitter for better syntax highlighting
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- File explorer
  use("kyazdani42/nvim-tree.lua")

  -- LSP Installer
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- Install luasnip and friendly-snippets
  use({
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use("chaoren/vim-wordmotion")

  -- Terminal
  use({ "akinsho/toggleterm.nvim", tag = "v2.12.0" })

  use({
    "amrbashir/nvim-docs-view",
    opt = true,
    cmd = { "DocsViewToggle" },
    config = function()
      require("docs-view").setup({
        position = "right",
        width = 50,
      })
    end,
  })

  use({
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        width = 120
      })
    end,
  })

  -- Automatically set up configuration after cloning packer.nvim
  -- This should be kept at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Null ls setup
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
})

-- Treesitter setup
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "python",
    "javascript",
    "typescript",
    "java",
    "rust",
    "lua",
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Lualine setup
require("lualine").setup({
  options = {
    theme = "everforest",
    section_separators = { "", "" },
    component_separators = { "", "" },
  },
})

-- Nvim-tree setup
require("nvim-tree").setup({
  view = {
    side = "left",
    width = 30,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "pyright", "gopls", "ts_ls", "rust_analyzer", "jdtls", "lua_ls" },
})

-- Setup luasnip with nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")
local lsp_servers = { "clangd", "pyright", "gopls", "ts_ls", "rust_analyzer", "jdtls", "lua_ls" }

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- Lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

for _, lsp in ipairs(lsp_servers) do
  if lsp ~= "lua_ls" then
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

-- Telescope setup
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    path_display = { "smart" },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "dropdown",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

require("telescope").load_extension("fzf")

-- Theme setup
vim.opt.termguicolors = true
vim.g.everforest_background = "soft"
vim.g.everforest_better_performance = 1
vim.g.everforest_disable_italic_comment = 1
vim.cmd("colorscheme everforest")

-- Syntax highlighting
vim.cmd("syntax on")

-- Terminal setup
require("toggleterm").setup({
  size = 20,
  open_mapping = [[<c-\>]], -- Toggle terminal with Ctrl-\
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = "1",    -- The degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true,  -- Whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "horizontal", -- 'vertical' | 'horizontal' | 'window' | 'float'
  close_on_exit = true,    -- Close the terminal window when the process exits
  shell = vim.o.shell,     -- Change the default shell
  float_opts = {
    border = "curved",     -- 'single' | 'double' | 'shadow' | 'curved'
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

--- Key mappings

-- Telescope 'Find Files'
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  ":Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob=!**/.git<CR>",
  { noremap = true, silent = true }
)
-- Telescope 'Find Grep' for text search
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
-- Telescope 'Find symbols'
vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { noremap = true, silent = true })
-- Telescope 'Find Workspace Symbols' -- Finds all symbols across the workspace rather than a single file
vim.api.nvim_set_keymap(
  "n",
  "<leader>fw",
  ":Telescope lsp_dynamic_workspace_symbols<CR>",
  { noremap = true, silent = true }
)
-- Telescope 'Find buffers'
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })

-- Telescope 'Format' -- Formats the current file asyncronously
vim.api.nvim_set_keymap(
  "n",
  "<leader>lf",
  ":lua vim.lsp.buf.format({ async = true })<CR>",
  { noremap = true, silent = true }
)

-- 'Git status'
vim.api.nvim_set_keymap("n", "<leader>gs", ":G<CR>", { noremap = true, silent = true })
-- 'Git diff'
vim.api.nvim_set_keymap("n", "<leader>gd", ":Gdiff<CR>", { noremap = true, silent = true })
-- 'Git diff --staged'
vim.api.nvim_set_keymap("n", "<leader>gds", ":Gdiff --staged<CR>", { noremap = true, silent = true })

-- Toggle/Update docs view
vim.api.nvim_set_keymap("n", "<leader>dt", ":DocsViewToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", ":DocsViewUpdate<CR>", { noremap = true, silent = true })

-- Close the current window
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Save the current file
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })

-- Mappings for opening terminals
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>th",
  ":ToggleTerm size=15 direction=horizontal<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>tv",
  ":ToggleTerm size=60 direction=vertical<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
-- Increase terminal height
vim.api.nvim_set_keymap("n", "<leader>+", ":resize +5<CR>", { noremap = true, silent = true })
-- Decrease terminal height
vim.api.nvim_set_keymap("n", "<leader>-", ":resize -5<CR>", { noremap = true, silent = true })
-- Increase terminal width (for vertical terminals)
vim.api.nvim_set_keymap("n", "<leader>>", ":vertical resize +5<CR>", { noremap = true, silent = true })
-- Decrease terminal width (for vertical terminals)
vim.api.nvim_set_keymap("n", "<leader><", ":vertical resize -5<CR>", { noremap = true, silent = true })
-- Map <Esc> in terminal mode to exit to normal mode
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Use Ctrl-[hjkl] to navigate between splits
vim.api.nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><space>", ":noh<CR>", { noremap = true, silent = true })

-- Key mapping to preview markdown
vim.api.nvim_set_keymap("n", "<leader>mp", ":Glow<CR>", { noremap = true, silent = true })
