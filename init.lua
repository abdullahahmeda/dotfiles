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

vim.pack.add {
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  -- { src = 'https://github.com/nvimtools/none-ls.nvim' },
  -- { src = 'https://github.com/nvimtools/none-ls-extras.nvim' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src ='https://github.com/neovim/nvim-lspconfig' },

  { src ='https://github.com/nyoom-engineering/oxocarbon.nvim' },
  -- { src = 'https://github.com/sainnhe/gruvbox-material' },
  
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  { src = 'https://github.com/nvim-mini/mini.pick' },
}

vim.lsp.enable({ 'ts_ls' })

require('oil').setup()
require('mason').setup()
require('blink.cmp').setup({
  keymap = { preset = 'default' },

  fuzzy = { implementation = 'lua' },

  completion = {
    menu = {
      auto_show = false
    }
  }
})
require('mini.pick').setup()

-- vim.cmd.colorscheme 'gruvbox-material'
vim.o.background = 'dark'
vim.cmd.colorscheme 'oxocarbon'

-- function custom_format()
--   vim.lsp.buf.format { range = nil }
-- end
--
-- vim.api.nvim_create_user_command('Format', custom_format, {})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 200 }
  end,
})

require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        [']f'] = '@function.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
      },
    },
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
}

-- local null_ls = require 'null-ls'
--
-- null_ls.setup {
--   sources = {
--     null_ls.builtins.formatting.stylua,
--     null_ls.builtins.formatting.prettierd,
--     require('none-ls.diagnostics.eslint_d').with {
--       diagnostics_format = '[eslint] #{m}\n(#{c})',
--     },
--   },
-- }

vim.keymap.set('n', '<leader>oo', ':Oil<CR>', { desc = 'Open file explorer' })

vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'Implementation' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Definition' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')

-- vim.keymap.set('n', '<leader>tt', function()
--   vim.cmd.new()
--   vim.cmd.wincmd 'J'
--   vim.cmd.term()
--   vim.api.nvim_win_set_height(0, 8)
-- end, { desc = 'Open terminal' })

local bufdelete = require 'plugins/bufdelete'
vim.keymap.set('n', '<leader>bd', bufdelete.delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bo', bufdelete.other, { desc = 'Keep the current buffer only', silent = true })

