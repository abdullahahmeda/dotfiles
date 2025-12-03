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
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/sindrets/diffview.nvim' },
  { src = 'https://github.com/NeogitOrg/neogit' },
  { src ='https://github.com/nyoom-engineering/oxocarbon.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  -- { src = 'https://github.com/sainnhe/gruvbox-material' },

  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  { src = 'https://github.com/nvim-mini/mini.pick' },
}

vim.lsp.enable({ 'ts_ls', 'intelephense', 'prismals' })

require('neogit').setup()
require('oil').setup()
require('mason').setup()
require('blink.cmp').setup({
  keymap = { 
    ['<C-k>'] = { 'show_documentation', 'hide_documentation' },
    ['<C-n>'] = { 'select_next', 'show' },
    ['<C-p>'] = { 'select_prev', 'show' },
    ['<C-y>'] = { 'select_and_accept' },
    -- ['<Tab>'] = { 'snippet_forward' },
    -- ['<S-Tab>'] = { 'snippet_backward' },
  },

  fuzzy = { implementation = 'lua' },
  cmdline = { enabled = false },

  completion = {
    menu = {
      auto_show = false,
      draw = {
      columns = {
        { "kind_icon", "label",  gap = 1 },
        { "kind", "label_description", gap = 2 }
      },
      }
    },
  }
})
require('mini.pick').setup()
require('lint').linters_by_ft = {
  javascript = {'eslint_d'},
  javascriptreact = {'eslint_d'},
  typescriptreact = {'eslint_d'},
  typescript = {'eslint_d'},
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require("conform").setup({
  formatters_by_ft = {
    javascript = {'prettierd'},
    javascriptreact = {'prettierd'},
    typescriptreact = {'prettierd'},
    typescript = {'prettierd'},
    html = {'prettierd'},
  },
})

require('lualine').setup({
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
  sections = {
    lualine_a = {
      {
        'mode',
        color = { gui = 'bold', bg = 'None', fg = 'None' }
      }
    },
    lualine_b = {
      {
        'branch',
        padding = 4
      },
    },
    lualine_c = {'filename',
    { 
      'lsp_status',
      padding = 4,
      icon = '',
      symbols = {
        done = ''
      }
  },
      'diagnostics'
  },
    lualine_x = {'diff',  'filetype'},
    lualine_z = {'location'}
  }
})

-- vim.cmd.colorscheme 'gruvbox-material'
vim.o.background = 'dark'
vim.cmd.colorscheme 'oxocarbon'

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
