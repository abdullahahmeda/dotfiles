vim.g.mapleader      = " "
vim.o.winborder      = "rounded"
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2
vim.o.expandtab      = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.cursorline     = true
vim.o.clipboard      = "unnamedplus"
vim.o.smartcase      = false
vim.o.signcolumn     = "yes"
vim.o.grepprg        = "rg --vimgrep --no-heading" 

vim.pack.add {
  -- dependencies
  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  -- file explorer & manager
  { src = 'https://github.com/stevearc/oil.nvim' },

  -- lsps, formatters and linters installer
  { src = 'https://github.com/williamboman/mason.nvim' },

  -- completion engine
  { src = 'https://github.com/saghen/blink.cmp' },

  -- treesitter, syntax highlighting
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },

  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- linter
  { src = 'https://github.com/mfussenegger/nvim-lint' },

  -- formatter
  { src = 'https://github.com/stevearc/conform.nvim' },

  -- git integration
  { src = 'https://github.com/NeogitOrg/neogit' },
  { src = 'https://github.com/sindrets/diffview.nvim' },

  -- colorscheme
  { src ='https://github.com/nyoom-engineering/oxocarbon.nvim' },
  -- { src = 'https://github.com/sainnhe/gruvbox-material' },

  -- status line
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },

  -- icons
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  -- picker (for files, folders, commands, help, grep, etc...)
  { src = 'https://github.com/nvim-mini/mini.pick' },
}

vim.lsp.enable({ 'ts_ls', 'intelephense', 'prismals' })

require('neogit').setup()
require('oil').setup()
require('mason').setup()
require('mini.pick').setup()

require 'setup.plugins.blink_cmp'
require 'setup.plugins.nvim-lint'
require 'setup.plugins.conform'
require 'setup.plugins.lualine'
require 'setup.plugins.nvim-treesitter'

require 'setup.highlight_on_yank'
require 'setup.colorscheme'


vim.keymap.set('n', '<leader>oo', ':Oil<CR>', { desc = 'Open file explorer' })

vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'Implementation' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Definition' })
vim.keymap.set('n', '<leader>lf', require('conform').format)
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>')

        -- vim.keymap.set('n', '<leader>tt', function()
          --   vim.cmd.new()
          --   vim.cmd.wincmd 'J'
          --   vim.cmd.term()
          --   vim.api.nvim_win_set_height(0, 8)
          -- end, { desc = 'Open terminal' })

local bufdelete = require 'plugins/bufdelete'
vim.keymap.set('n', '<leader>bd', bufdelete.delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bo', bufdelete.other, { desc = 'Keep the current buffer only', silent = true })
