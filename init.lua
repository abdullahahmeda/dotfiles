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
vim.o.termbidi       = true
-- vim.o.grepprg        = "rg --vimgrep --no-heading" 

vim.pack.add {
  -- file explorer & manager
  { src = 'https://github.com/stevearc/oil.nvim' },

  -- lsps, formatters and linters installer
  { src = 'https://github.com/williamboman/mason.nvim' },

  -- config for lsps
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- linter
  { src = 'https://github.com/mfussenegger/nvim-lint' },

  -- formatter
  { src = 'https://github.com/stevearc/conform.nvim' },

  -- completion
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },

  -- git integration
  -- use lazygit

  -- colorscheme
  { src = 'https://github.com/rebelot/kanagawa.nvim' },

  -- picker (for files, folders, commands, help, grep, etc...)
  { src = 'https://github.com/nvim-mini/mini.pick' },

  -- Multicursor
  { src = 'https://github.com/jake-stewart/multicursor.nvim' },

  -- Copilot
  -- { src = 'https://github.com/zbirenbaum/copilot.lua' }
}

vim.lsp.enable({ 'tsgo', 'gopls', 'phpantom_lsp', 'basedpyright' })

require('oil').setup()
require('mason').setup()
-- require('copilot').setup()
-- require('copilot').setup({
--   suggestion = {
--     accept = '<C-y>',
--     next = '<C-n>',
--     prev = '<C-p>',
--     dismiss = '<C-q>'
--   }
-- })

require 'config.plugins.mini_pick'
require 'config.plugins.blink_cmp'
require 'config.plugins.nvim-lint'
require 'config.plugins.conform'
require 'config.plugins.multicursor'

require 'config.highlight_on_yank'
require 'config.colorscheme'


vim.keymap.set('n', '<leader>oo', ':Oil<CR>', { desc = 'Open file explorer' })
-- vim.keymap.set('n', '<leader>oo', ':Explore<CR>', { desc = 'Open file explorer' })

vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP Code actions' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { desc = 'LSP References' })
vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { desc = 'LSP Type definition' })
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { desc = 'LSP Implementation' })
vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'LSP Definition' })
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'LSP Declaration' })
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, { desc = 'LSP Document Sybmols' })
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { desc = 'LSP Signature help' })
vim.keymap.set('n', '<leader>ll', require('lint').try_lint, { desc = 'Lint' })
vim.keymap.set('n', '<leader>lf', require('conform').format, { desc = 'LSP Format' })

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fg', ':Pick grep<CR>')
vim.keymap.set('n', '<leader>fr', ':Pick resume<CR>')
vim.keymap.set('n', '<leader>gg', ':G<CR>')

local bufdelete = require 'plugins/bufdelete'
vim.keymap.set('n', '<leader>bd', bufdelete.delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bo', bufdelete.other, { desc = 'Keep the current buffer only', silent = true })
